
precision mediump float;

uniform float u_time;
uniform vec2 u_resolution;

uniform sampler2D u_texture_x2;

float circle(vec2 pos, vec2 center, float radius)
{
  float l = length(pos - center);
  if (l > radius)
    return 0.0;
  else
    return 1.0;
}

void main()
{
  vec2 coord = gl_FragCoord.xy / u_resolution.xy;
  float x = sin(2.0 * u_time);
  float y = cos(u_time);
  vec2 newCoord = coord + 0.3 * vec2(x, y);
  gl_FragColor = vec4(vec3(1.0) * circle(newCoord, vec2(0.5), 0.1), 1.0);
}
