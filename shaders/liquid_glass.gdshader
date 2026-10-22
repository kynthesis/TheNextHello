shader_type canvas_item;
render_mode unshaded;

uniform sampler2D backdrop : hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform vec2 rect_size = vec2(360.0, 100.0);
uniform float radius = 26.0;
uniform vec4 tint : source_color = vec4(0.97, 0.98, 1.0, 0.25);
uniform float pixel_scale = 1.0;
uniform float blur = 2.3;
uniform float refraction = 7.0;
uniform vec2 pointer_position = vec2(-1000.0);
varying vec2 local_position;

float round_box(vec2 p, vec2 half_size, float r) {
    vec2 q = abs(p) - half_size + vec2(r);
    return length(max(q, vec2(0.0))) + min(max(q.x, q.y), 0.0) - r;
}

void vertex() {
    local_position = VERTEX;
}

void fragment() {
    vec2 half_size = rect_size * 0.5;
    float r = min(radius, min(half_size.x, half_size.y));
    vec2 p = local_position - half_size;
    float d = round_box(p, half_size, r);
    float aa = max(fwidth(d), 0.5);
    float mask = 1.0 - smoothstep(-aa, aa, d);
    vec2 normal = normalize(vec2(
        round_box(p + vec2(0.6, 0.0), half_size, r) - round_box(p - vec2(0.6, 0.0), half_size, r),
        round_box(p + vec2(0.0, 0.6), half_size, r) - round_box(p - vec2(0.0, 0.6), half_size, r)
    ) + vec2(0.0001));
    float rim = 1.0 - smoothstep(0.0, 22.0, -d);
    vec2 bend = normal * rim * rim * refraction * pixel_scale * SCREEN_PIXEL_SIZE;
    vec2 sample_uv = SCREEN_UV - bend;
    vec3 refracted = textureLod(backdrop, sample_uv, blur).rgb;
    // A restrained color split only at the curved edge makes the surface read as glass.
    refracted.r = mix(refracted.r, textureLod(backdrop, sample_uv - bend * 0.13, blur).r, rim * 0.35);
    refracted.b = mix(refracted.b, textureLod(backdrop, sample_uv + bend * 0.13, blur).b, rim * 0.35);
    vec3 glass = mix(refracted, tint.rgb, tint.a);
    float light = 0.5 + 0.5 * dot(normal, normalize(vec2(-0.7, -1.0)));
    float edge = 1.0 - smoothstep(0.6, 1.8, abs(d + 1.3));
    float pointer_light = exp(-dot(local_position - pointer_position, local_position - pointer_position) / 10000.0);
    glass += vec3(1.0) * edge * (0.12 + 0.48 * light + pointer_light * 0.22);
    glass += vec3(0.06, 0.07, 0.1) * pow(1.0 - clamp(local_position.y / rect_size.y, 0.0, 1.0), 5.0);
    glass -= vec3(0.035) * rim * (1.0 - light);
    COLOR = vec4(clamp(glass, vec3(0.0), vec3(1.0)), mask);
}
