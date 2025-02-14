shader_type canvas_item;
#define C(x) sin(x) * 0.5 +0.5
uniform vec2 resolution = vec2(600.0, 400.0);
uniform int octaves: hint_range(1,10, 1) = 5;
uniform float speed: hint_range(0.1, 4.0, 0.1) = 1.0;
uniform float frequency: hint_range(0.1, 1.0, 0.1) = 1.0;
uniform float amplitude: hint_range(0.1, 1.0, 0.1) = 1.0;
uniform float time_shift: hint_range(0.1, 1.0, 0.1) = 0.5;
uniform float zoom: hint_range(1.0, 20.0, 0.1) = 5.0;

vec2 warp (vec2 uv, float time) {
    float f = frequency;
    float a = amplitude;
    float t = time_shift;
    for (int s= 0; s < octaves; s++) {
        uv += vec2(sin(uv.y *f +time *t), cos(uv.x * f +time * t)) / a;
        f *= 1.9;
        t *= 0.9;
        a *= 2.0;
    }
    return uv;
}

void fragment() {
    float time = TIME * speed;
    vec2 uv = UV - 0.5;
    uv.x *= resolution.x / resolution.y;
    uv *= zoom;
    uv = warp(uv,time);

    // Generate a single base value for color mixing
    float pattern = C(uv.x * uv.y + time);

    // Define our three main colors
    vec3 darkBlue = vec3(0.0, 0.05, 0.2);
    vec3 purple = vec3(0.2, 0.0, 0.3);
    vec3 black = vec3(0.0, 0.0, 0.0);  // Changed from brown to pure black

    // Create the main color by mixing between our three colors
    vec3 color;
    float mixValue = C(uv.x + uv.y + time);

    if (mixValue < 0.33) {
        color = mix(darkBlue, purple, mixValue * 3.0);
    } else if (mixValue < 0.66) {
        color = mix(purple, black, (mixValue - 0.33) * 3.0);
    } else {
        color = mix(black, darkBlue, (mixValue - 0.66) * 3.0);
    }

    // Add some variation in darkness
    float darkness = C(uv.x * 2.0 + time) * 0.5 + 0.5;
    color *= darkness;

    COLOR = vec4(color, 1.0);
}