Shader "Custom/X-Rayed_object"
{
   Properties{
        _ObjColor("Color", Color) = (1,1,1,1)
        _xRayedColor("xray Color", Color) = (1,1,1,1)
        _RimSharpness("rim sharpness", Range (1,10)) = 1.2
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
    //1-� ���� ��� ����������� ����, ��� �� �������
        Pass{
            
            Stencil{
                Ref 1
                Comp notequal
                Pass keep
            }

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f{
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            float4 _ObjColor, _xRayedColor;
            float _RimSharpness;

            v2f vert (appdata_full v){
                v2f o;
                o.vertex = UnityObjectToClipPos (v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 clr = _ObjColor;
                return clr;
            }
            ENDCG
        }
        //2-� ���� - ��� ��������
        Pass{  
            Stencil{
                    Ref 1
                    Comp equal
                    Pass keep
                }
            //Tags { "Queue"="Geometry" }
            Blend One One
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f{
                float4 pos : SV_POSITION;// SV_ ��������, ��� ��� ���������� ��������� ��-��
                float4 color : COLOR;
                float3 normal : NORMAL;
                float4 posWorld : TEXCOORD0;//TEXCOORD0 ����� ��� ��������� ��� �������� �� frag 
            };
            float4 _ObjColor, _xRayedColor;
            float _RimSharpness;
            v2f vert (appdata_full v){
                v2f o;
                o.pos = UnityObjectToClipPos (v.vertex);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);//�������� �� ������� unity_ObjectToWorld ����� �������� ������ � ����
                o.normal = normalize (mul(float4(v.normal,0.0), unity_WorldToObject).xyz);// � �� �� ����� � ���������
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 clr = _xRayedColor;
                float3 normalDir = i.normal;
                float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);//��������, ����� �������� ������ viewDir. ����� ��������� ���
                float rim = 1 - saturate(dot(viewDir, normalDir));//�� � ������ �� ��� � surface-�������
                float3 rimLight = pow(rim, _RimSharpness) * _xRayedColor * 10;
                clr = float4 (clr.rgb + rimLight, 0.4);
                //half rim = 1.0 - saturate (dot (normalize (i.viewDir)), i.Normal);
                //clr = _xRayedColor.rgb * pow(rim, 2) * 10;
                return clr;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
