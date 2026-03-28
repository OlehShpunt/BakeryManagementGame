shader_type canvas_item;

uniform vec4 outline_color = vec4(1,1,1,1);
uniform float outline_thickness : hint_range(1,5) = 1.0;
uniform bool outline_enabled = true;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    vec4 final_color = tex;

    if (outline_enabled && tex.a == 0.0) {
        float alpha = 0.0;
        vec2 pixel = 1.0 / vec2(textureSize(TEXTURE,0));
        for (int x=-1; x<=1; x++) {
            for (int y=-1; y<=1; y++) {
                vec2 offset = vec2(float(x), float(y)) * pixel * outline_thickness;
                alpha = max(alpha, texture(TEXTURE, UV+offset).a);
            }
        }
        if (alpha > 0.0) {
            final_color = outline_color;
        }
    }

    COLOR = final_color;
}