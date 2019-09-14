precision mediump float;

uniform sampler2D u_texture_boom;
uniform vec2 u_resolution;
uniform float u_time;

void main()
{
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec4 color = texture2D(u_texture_boom, coords);

    float x = 0.5 * (1.0 + sin(2.0 * u_time)) * (u_resolution.x + u_resolution.y);
    float size = 80.0;

    vec3 add = vec3(0.0);

    float sum = gl_FragCoord.x + gl_FragCoord.y;
    if (x - size < sum && sum < x + size) {
        float c = cos((x - sum) / (2.0 * size) * 3.14);
        add = vec3(0.5) * c;
    }

    gl_FragColor = vec4(color.rgb + add, color.a);
}
