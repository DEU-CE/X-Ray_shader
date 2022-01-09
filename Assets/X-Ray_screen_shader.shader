Shader "Custom/X-Ray_screen_shader"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }//��� ��������������� �� ���������, � �������-������ ����� �� �������� � 1� �������

        ColorMask 0//�� ���������� ����
        ZWrite off//�� ������� Z-������

        Stencil{
            Ref 1 //���������� � ������� 1
            Comp always
            Pass replace// ��� ������ ��� � ������ ����� ������ ��, ��� � �� ���� �� ����� �� ��, ��� ���� � ������� ����� �������
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
