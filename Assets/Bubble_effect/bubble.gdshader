shader_type canvas_item;

uniform float time;
uniform vec2 scale = vec2(10.0, 10.0);

float noise(vec2 p) {
    return fract(sin(dot(p * scale, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = UV;
    float n = noise(uv + time);
    COLOR = vec4(vec3(n), 1.0);  // Set the color based on noise
}