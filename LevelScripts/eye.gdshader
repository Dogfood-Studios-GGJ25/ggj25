shader_type spatial;
render_mode unshaded, blend_mix, depth_test_disabled, cull_disabled;

uniform sampler2D TEXTURE : source_color, filter_linear_mipmap;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    ALBEDO = tex.rgb;
    ALPHA = tex.a;
}