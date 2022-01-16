Shader "Custom/X-Ray_screen_shader"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }//��� ��������������� �� ���������, � �������-������ ����� �� �������� � 1� �������       

        //���� ��� ���������� ��������
        Pass{
            //ColorMask 0//�� ���������� ����
            ZWrite off//�� ������� Z-������

            Stencil{
                Ref 1 //���������� � ������� 1
                Comp notequal//always
                Pass replace// ��� ������ ��� � ������ ����� ������ ��, ��� � �� ���� �� ����� �� ��, ��� ���� � ������� ����� �������
            }

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f{
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata_full v){
                v2f o;
                o.vertex = UnityObjectToClipPos (v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target{
                return float4(0,0,0,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
