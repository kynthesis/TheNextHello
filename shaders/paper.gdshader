shader_type canvas_item;
render_mode unshaded;

// Stationary, low-contrast fibers. No screen sampling or animated grain.
void fragment() {
	vec2 cell = floor(UV * vec2(180.0, 120.0));
	float grain = fract(sin(dot(cell, vec2(12.9898, 78.233))) * 43758.5453);
	COLOR.rgb *= 0.975 + grain * 0.025;
}
