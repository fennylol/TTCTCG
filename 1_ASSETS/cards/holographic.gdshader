shader_type spatial;
render_mode blend_mix, depth_draw_opaque, diffuse_burley, specular_schlick_ggx, cull_disabled;
uniform float color_compression = 8.0;
uniform sampler2D texture_albedo : source_color, filter_nearest;

uniform sampler2D texture_noise;
uniform float noise_strength : hint_range(0.0, 1.0) = 0.3;
uniform float noise_scale = 1.0;

varying vec3 world_pos;

vec3 hsv2rgb(vec3 hsv) {
	float h = hsv.x * color_compression; 
	float s = hsv.y;
	float v = hsv.z;
	
	float c = v * s;
	float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
	vec3 rgb = vec3(0.0);
	
	if (0.0 <= h && h < 1.0) rgb = vec3(c, x, 0.0);
	else if (1.0 <= h && h < 2.0) rgb = vec3(x, c, 0.0);
	else if (2.0 <= h && h < 3.0) rgb = vec3(0.0, c, x);
	else if (3.0 <= h && h < 4.0) rgb = vec3(0.0, x, c);
	else if (4.0 <= h && h < 5.0) rgb = vec3(x, 0.0, c);
	else if (5.0 <= h && h < 6.0) rgb = vec3(c, 0.0, x);
	
	return rgb + (v - c);
}

/*
Converts a value in range [istart, istop] to a value in range [ostart, ostop].
*/
float range_lerp(float value, float istart, float istop, float ostart, float ostop) {
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
}

void fragment() {
	vec3 albedo = texture(texture_albedo, UV).rgb;
	ALBEDO = albedo;
	EMISSION = albedo * 0.125;
	
	//world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}


void light() {
	vec3 normal_dir = normalize(NORMAL);
	vec3 view_dir = normalize(VIEW);
	vec3 light_dir = normalize(LIGHT);
	float angle = abs(dot(view_dir, normal_dir));
	
	
	vec3 color = hsv2rgb((vec3(angle*0.75, 0.75, 0.75)));
	angle = 1.0-pow(angle, 0.5);
	
	//float world_xz = (world_pos.x + world_pos.z)/2.0;
	//vec2 world_uv = vec2(world_xz, world_pos.y);
	//float noise = texture(texture_noise, world_uv * angle).r;
	//noise = (noise - 0.5) * 2.0 * noise_strength;
	//color *= 0.5 + (0.5*noise);
	
	
	SPECULAR_LIGHT += angle * color * LIGHT_COLOR * ATTENUATION;
}
