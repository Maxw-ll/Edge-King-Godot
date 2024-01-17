shader_type canvas_item;

uniform float time_multiplicator= 4.0;
uniform float scale_multiplicator = 2.0;

void vertex() {
	VERTEX.y += sin(TIME*time_multiplicator)*scale_multiplicator;
}

