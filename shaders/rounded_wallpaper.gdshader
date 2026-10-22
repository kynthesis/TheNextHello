shader_type canvas_item;
render_mode unshaded;
uniform vec2 rect_size = vec2(394.0, 876.0);
uniform float radius = 16.0;
void fragment() {
    vec2 p = (UV - vec2(0.5)) * rect_size;
    vec2 q = abs(p) - rect_size * 0.5 + vec2(radius);
    float distance = length(max(q, vec2(0.0))) + min(max(q.x, q.y), 0.0) - radius;
    vec4 wallpaper = texture(TEXTURE, UV);
    wallpaper.a *= 1.0 - smoothstep(-max(fwidth(distance), 0.5), 0.0, distance);
    COLOR = wallpaper;
}
