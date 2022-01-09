Shader "Custom/X-Rayed_object"
{
   Properties
    {
        _ObjColor("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        Stencil{
            Ref 1
            Comp notequal
            Pass keep
        }

        CGPROGRAM

        #pragma surface surf Lambert


        sampler2D _MainTex;
        float4 _ObjColor;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _ObjColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
