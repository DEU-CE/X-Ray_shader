Shader "Custom/X-Ray_screen_shader"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }//шоб прорисовывалось до геометрии, и рентген-объект дойдёт до стенсила в 1ю очередь       

        //пасс для собственно рентгена
        Pass{
            //ColorMask 0//не записываем цвет
            ZWrite off//не трогаем Z-буффер

            Stencil{
                Ref 1 //записываем с стенсил 1
                Comp notequal//always
                Pass replace// это значит что в буфере кадра меняем то, что в нём было до этого на то, что есть в пикселе этого шейдера
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
