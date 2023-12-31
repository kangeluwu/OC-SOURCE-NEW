#pragma header
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
#define TWO_PI 6.2831
uniform float curPower = 1;
vec3 Effect(float speed, vec2 uv, float time)
{
    float t = mod(105.*time*speed,60.0);
    float rt =0.01*sin(t*0.45);
    mat2 m1 = mat2(cos(rt),-sin(rt),-sin(rt),cos(rt));
    vec2 uva=uv*m1;
    float irt = 0.005* cos(t*0.05);
    mat2 m2 = mat2(sin(irt),cos(irt),-cos(irt),sin(irt));
    for(int i=1;i<40;i+=1)
    {   
        float it = float(i);
        uva*=(m2);
        uva.y+=-1.0+(0.6/it) * cos(t + it*uva.x + 0.5*it)
        *float(mod(it,2.0)==0.0);
        uva.x+=1.0+(0.5/it) * cos(t + it*uva.y + 0.5*(it+15.0));
    }
    //Intensity range from 0 to n;
    float n = 0.5;
    float r = n + n * sin(4.0*uva.x+t);
    float gb = n + n * sin(3.0*uva.y);
    return vec3(r,gb*0.8*r,gb*r);
}
void mainImage(  )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    //vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

    // Output to screen
    fragColor = vec4(Effect(.02,uv,iTime)*curPower,curPower);

    gl_FragColor.a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;
}