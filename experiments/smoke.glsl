precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform sampler2D u_texture_perlin_noise;

uniform sampler2D u_buffer0;
uniform sampler2D u_buffer1;

void smoke(sampler2D otherBuffer)
{
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec4 noise = texture2D(u_texture_perlin_noise, coords - vec2(0.0, 0.1 * u_time));

    float fadeC = 0.95 * (1.0 - coords.y);
    vec4 color = fadeC * texture2D(otherBuffer, coords, 0.0);

    float c = 0.01;
    gl_FragColor = vec4(color.rgb + noise.rgb * c, 1.0);
}

#if defined(BUFFER_0)

void main()
{
    smoke(u_buffer1);
}

#elif defined(BUFFER_1)

void main()
{
    smoke(u_buffer0);
}

#else

void main()
{
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec4 color = texture2D(u_buffer1, coords, 0.0);
    gl_FragColor = 0.0 * vec4(0.5 * sin(u_time) + 0.5) + color;
}

#endif
