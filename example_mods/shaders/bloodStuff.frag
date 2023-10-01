#pragma header

void main() {
    vec2 ab = flixel_texture2D(bitmap, openfl_TextureCoordv).xy;
    gl_FragColor = vec4(ab.y * 1.0, 0.0, 0.0, 1.0);
    gl_FragColor.a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;
}