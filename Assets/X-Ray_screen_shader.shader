Shader "Custom/X-Ray_screen_shader"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }//шоб прорисовывалось до геометрии, и рентген-объект дойдёт до стенсила в 1ю очередь

        ColorMask 0//не записываем цвет
        ZWrite off//не трогаем Z-буффер

        Stencil{
            Ref 1 //записываем с стенсил 1
            Comp always
            Pass replace// это значит что в буфере кадра меняем то, что в нём было до этого на то, что есть в пикселе этого шейдера
        }

        CGPROGRAM

        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
        }
        ENDCG
    }
    FallBack "Diffuse"
}
