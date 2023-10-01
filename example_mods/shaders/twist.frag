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
vec2 rotate (vec2 coord, float angle){
    float sin_factor = sin(angle);
    float cos_factor = cos(angle);
	vec2 c = vec2((coord.x - 0.5) * (iResolution.x / iResolution.y), coord.y - 0.5) * mat2(cos_factor, sin_factor, -sin_factor, cos_factor);
    c += 0.5;
    return c;
}


void mainImage()
{
    vec2 res = iResolution.xy;
	vec2 uv = fragCoord.xy ;
    vec2 tc = uv / res;
    
    /*
    vec2 center = res*0.5;
    vec2 diff =  vec2(uv.y - center.y, uv.x - center.x);
    float r = length(diff)/res.y;
    float angle = atan(diff.y, diff.x) + mod(iTime*1.2, TWO_PI) - r;
    uv = center + r * vec2(cos(angle ),sin(angle )) + vec2(0.5);
    vec2 newPos = floor(mod(uv,vec2(1.0)) * rings)/rings;
    */
    
    float rings = 30.0;
    float d = 1.0 - floor(distance(vec2(0.5 * (res.x/res.y), 0.5),vec2(tc.x * (res.x/res.y), tc.y))*rings)/rings;
	gl_FragColor = texture(iChannel0, tc + rotate(tc, iTime)*d * curPower);
    gl_FragColor.a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;
}