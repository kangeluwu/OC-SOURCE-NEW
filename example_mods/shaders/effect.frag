#pragma header
uniform float powerMinusX = 0.0;
uniform float powerMinusY = 0.0;
uniform float powerPlusX = 0.0;
uniform float powerPlusY = 0.0;

uniform float moving = 0.0;
//Estranged Effect
uniform float rgbValueLmao = 0.0;
uniform bool isCamera;
uniform bool isSpriteLeft;
uniform bool isSpriteRight;
//CPICO Effect

vec3 yooVidX(vec2 uv)
{
	vec2 look = uv;
	float vShift = (sin(moving * moving * 0.001));
    float vShift2 = -vShift;
	look.x = mod(look.x + vShift, 1.);
	vec3 video = vec3(flixel_texture2D(bitmap,look));
	return video;
}
vec2 screen(vec2 uv)
{
	uv -= vec2(.5,.5);
	uv.x *= 1.0 - pow((abs(uv.y) * powerMinusX), 2.0) + pow((abs(uv.y) * powerPlusX), 2.0);
	uv.y *= 1.0 - pow((abs(uv.x) * powerMinusY), 2.0) + pow((abs(uv.x) * powerPlusY), 2.0);
	uv += vec2(.5,.5);
	return uv;
}
void main()
{
	 vec2 q = openfl_TextureCoordv;
    vec2 uv = q;
	uv = screen(uv);
	float vShift = (sin(moving * moving * 0.001));
	uv.x = mod(uv.x + vShift, 1.);
	vec3 video = yooVidX(uv);
	
	float rgbDude = 0.0;
	
	rgbDude = rgbValueLmao * 0.5;

	rgbDude = pow(rgbDude, 1.0);

	rgbDude *= 0.05;
	
	if (isCamera){
	if (uv.x < 1.0-uv.x){
    video.r = flixel_texture2D( bitmap, vec2(uv.x+rgbDude*2.0,uv.y) ).r;
	video.g = flixel_texture2D( bitmap, vec2(uv.x+rgbDude,uv.y) ).g;

	}
	else if (uv.x > 1.0-uv.x){
    video.r = flixel_texture2D( bitmap, vec2(uv.x-rgbDude*2.0,uv.y) ).r;
	video.g = flixel_texture2D( bitmap, vec2(uv.x-rgbDude,uv.y) ).g;
    
	}
	else{
		video.r = flixel_texture2D( bitmap, uv ).r;
	video.g = flixel_texture2D( bitmap, uv ).g;
	}
video.b = flixel_texture2D( bitmap, uv ).b;
	}
	else{
		if (isSpriteLeft){
			if (uv.x < 1.0-uv.x){
    video.r = flixel_texture2D( bitmap, vec2(uv.x+rgbDude*2.0,uv.y) ).r;
	video.g = flixel_texture2D( bitmap, vec2(uv.x+rgbDude,uv.y) ).g;
	video.b = flixel_texture2D( bitmap, uv ).b;

	}
		else if (!isSpriteRight){
    video.r = flixel_texture2D( bitmap, vec2(uv.x+rgbDude*2.0,uv.y) ).r;
	video.g = flixel_texture2D( bitmap, vec2(uv.x+rgbDude,uv.y) ).g;
	video.b = flixel_texture2D( bitmap, uv ).b;
	}
		}
		if (isSpriteRight){
	 if (uv.x > 1.0-uv.x){
    video.r = flixel_texture2D( bitmap, vec2(uv.x-rgbDude*2.0,uv.y) ).r;
	video.g = flixel_texture2D( bitmap, vec2(uv.x-rgbDude,uv.y) ).g;
	video.b = flixel_texture2D( bitmap, uv ).b;
    
	}
	else if (!isSpriteLeft){
video.r = flixel_texture2D( bitmap, vec2(uv.x-rgbDude*2.0,uv.y) ).r;
	video.g = flixel_texture2D( bitmap, vec2(uv.x-rgbDude,uv.y) ).g;
	video.b = flixel_texture2D( bitmap, uv ).b;
	}
		}
	if(!isSpriteLeft && !isSpriteRight){
		video.r = flixel_texture2D( bitmap, uv ).r;
	video.g = flixel_texture2D( bitmap, uv ).g;
	video.b = flixel_texture2D( bitmap, uv ).b;
	}

	}
	video *= (1.0 - rgbDude * 0.5);
	
	gl_FragColor = vec4(video,1.0);
	gl_FragColor.a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;
}