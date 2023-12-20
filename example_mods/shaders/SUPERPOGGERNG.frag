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
// original by bsdBeard https://www.shadertoy.com/view/4d2XR1, slightly modified
#define ray_brightness 10.
#define gamma 5.
#define ray_density 4.5
#define curvature 15.
#define red   4.
#define green 1.0
#define blue  .3 


// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!! UNCOMMENT ONE OF THESE TO CHANGE EFFECTS !!!!!!!!!!!
// MODE IS THE PRIMARY MODE
#define MODE normalize
// #define MODE 

#define MODE3 *
// #define MODE3 +
#define innerCircleScale 0.5 

#define MODE2 r +
// #define MODE2 

// #define DIRECTION +
#define DIRECTION -

#define SIZE 0.1

#define INVERT /
// #define INVERT *
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// Inner circle scale
#define innerCircleScale 0.5

// Smaller force field parameters
#define smallForceCenter vec2(0.3, 0.3)
#define smallForceStrength 3.0
#define smallForceRadius 0.1

// Larger force field parameters
#define largeForceCenter vec2(0.0, 0.0)
#define largeForceStrength 5.0
#define largeForceRadius 0.3

float noise(in vec2 x) {
    return sin(x.x * 10.0) + sin(x.y * 10.0);
}

mat2 m2 = mat2(0.80, 0.60, -0.60, 0.80);
float fbm(in vec2 p) {	
    float z = 20.;
    float rz = -0.01;
    p *= 0.25;
    for (int i = 1; i < 6; i++) {
        rz += abs((noise(p) - 0.5) * 2.) / z;
        z = z * 2.;
        p = p * 2. * m2;
    }
    return rz;
}

void mainImage() {
    vec2 prevMouse = vec2(0.0);
    vec2 mouseDelta = fragCoord.xy / iResolution.xy;
 
    
    float t = DIRECTION iTime * .33; 
    vec2 uv = fragCoord.xy / iResolution.xy - 0.5;
    uv.x *= iResolution.x / iResolution.y;
    uv *= curvature * SIZE;
     uv *= 1.5;
    float r = sqrt(dot(uv, uv));
    float x = dot(normalize(uv), vec2(.5, 0.)) + t;
    float y = dot(normalize(uv), vec2(.0, .5)) + t;
    
    float val;
    val = fbm(vec2(r * ray_density, x * ray_density)); // Updated to use r and x directly
    val = smoothstep(gamma * .01 - .1, ray_brightness + (gamma * 0.02 - .1) + .001, val);
    val = sqrt(val);
    
    r *= mix(1., innerCircleScale, smoothstep(0.1, 0.3, r));
    
    // Apply force fields
    vec2 smallForces = normalize(smallForceCenter - uv) * smallForceStrength / (length(smallForceCenter - uv) + smallForceRadius);
    vec2 largeForces = normalize(largeForceCenter - uv) * largeForceStrength / (length(largeForceCenter - uv) + largeForceRadius);
    
    uv += smallForces + largeForces;

    vec3 col = val INVERT vec3(red, green, blue);
    col = 1. - col;
    col = mix(col, vec3(1.), 30. * r - 266.667 * r);
    
    fragColor = vec4(col*curPower, curPower);

    gl_FragColor.a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;
}