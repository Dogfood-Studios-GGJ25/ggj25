shader_type sky;

// Original uniforms
uniform sampler2D sky_tex : source_color;
uniform float energy : hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float gamma : hint_range(0.0,4.0) = 1.0;
uniform sampler2D tint_ramp : source_color, repeat_disable, hint_default_white;
uniform vec3 scale = vec3(1);
uniform float triplanar_blend_power : hint_range(0.0,40.0) = 4.0;
uniform float seamless_blend : hint_range(0.0,0.5) = 0.1;

// Movement uniforms
uniform float movement_speed : hint_range(0.0, 1.0, 0.01) = 0.1;
uniform vec2 movement_direction = vec2(1.0, 0.5);

vec4 textureSeamless(sampler2D tex, vec2 uv, vec2 padding) {
    vec2 inv_scale = 1.0 / (1.0 + 2.0 * padding);
    
    // Get partial derivatives for textureGrad() to avoid mipmapping seams
    vec2 dx = dFdx(uv) * inv_scale;
    vec2 dy = dFdy(uv) * inv_scale;
    
    // Textures need to repeat somewhere
    uv = fract(uv + 0.5) - 0.5;
    
    // Get the bilinear blend factors
    vec2 u = smoothstep(-padding, padding, uv);
    
    // Apply scale
    uv *= inv_scale;
    
    // Bilinear interpolation
    inv_scale = 0.5 * (1.0 - inv_scale);
    vec4 lower_right = textureGrad(tex, uv - vec2(-1,-1) * inv_scale, dx, dy);
    vec4 lower_left = textureGrad(tex, uv - vec2(1,-1) * inv_scale, dx, dy);
    vec4 upper_right = textureGrad(tex, uv - vec2(-1,1) * inv_scale, dx, dy);
    vec4 upper_left = textureGrad(tex, uv - vec2(1,1) * inv_scale, dx, dy);
    
    lower_right = mix(lower_left, lower_right, u.x);
    upper_right = mix(upper_left, upper_right, u.x);
    return mix(upper_right, lower_right, u.y);
}

vec4 boxmap(in sampler2D s, in vec3 p, in vec3 n, in float k) {
    // Add time-based movement to coordinates
    vec2 time_offset = movement_direction * TIME * movement_speed;
    
    // Project+fetch with movement
    vec4 x = textureSeamless(s, p.yz + time_offset, vec2(seamless_blend));
    vec4 y = textureSeamless(s, p.zx + time_offset, vec2(seamless_blend));
    vec4 z = textureSeamless(s, p.xy + time_offset, vec2(seamless_blend));
    
    // Blend weights
    vec3 w = pow(abs(n), vec3(k));
    
    // Blend and return
    return (x*w.x + y*w.y + z*w.z) / (w.x + w.y + w.z);
}

void sky() {
    // Ray direction
    vec3 rd = EYEDIR;
    
    // Apply scaling
    vec3 p = rd;
    p = normalize(rd / scale) * scale;
    vec3 n = normalize(p / scale);
    
    // Triplanar mapping of sky texture
    COLOR = boxmap(sky_tex, p, n, triplanar_blend_power).rgb;
    COLOR = energy * pow(COLOR, vec3(gamma));
    
    // Apply tint ramp
    vec4 tint = textureLod(tint_ramp, SKY_COORDS.yx, 0.0);
    COLOR = mix(tint.rgb, COLOR, tint.a);
}