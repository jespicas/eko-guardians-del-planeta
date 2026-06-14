shader_type canvas_item;

uniform float wave_speed : hint_range(0.1, 5.0) = 1.5;
uniform float wave_amplitude : hint_range(0.001, 0.05) = 0.005;
uniform float wave_frequency : hint_range(1.0, 50.0) = 10.0;
uniform vec4 water_tint : source_color = vec4(0.0, 0.5, 0.8, 0.2);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // Creamos una distorsión basada en el tiempo y la posición
    // Usamos senos cruzados para que el movimiento no sea solo horizontal
    float displacement_x = sin(TIME * wave_speed + uv.y * wave_frequency) * wave_amplitude;
    float displacement_y = cos(TIME * wave_speed + uv.x * wave_frequency) * wave_amplitude;
    
    vec2 distorted_uv = uv + vec2(displacement_x, displacement_y);
    
    // Obtenemos la textura de la pantalla con la UV distorsionada
    vec4 screen_color = texture(SCREEN_TEXTURE, distorted_uv);
    
    // Mezclamos con el color del agua usando el canal alpha de water_tint
    COLOR = mix(screen_color, water_tint, water_tint.a);
}