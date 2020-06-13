precision mediump float;

#define u_IMAGE u_texture_sea

uniform sampler2D u_IMAGE;
uniform sampler2D u_texture_polaroid;
uniform sampler2D u_texture_perlin_noise;

uniform vec2 u_resolution;
uniform float u_time;

#define uv gl_FragCoord.xy / u_resolution.xy

float APPEAR_TIME = 5.0;
float NOISE_MULTIPLIER = 0.6;
float COLOR_MULTIPLIER = 1.5;
float MAX_COLOR = 2.1;

float luminance(vec3 color)
{
    return 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
}

void main()
{
    vec4 color = texture2D(u_IMAGE, uv);

    float time = mod(u_time, 3.0 * APPEAR_TIME);
    float overallProgress = max(0.0, min(MAX_COLOR, time / APPEAR_TIME));
    float noiseDelay = NOISE_MULTIPLIER * texture2D(u_texture_perlin_noise, uv).r;
    float colorDelay = COLOR_MULTIPLIER * luminance(color.rgb);

    colorDelay = 1.0 - colorDelay;
    colorDelay = colorDelay * colorDelay;
    colorDelay = 1.0 - colorDelay;

    float progress = max(0.0, min(1.0, overallProgress - noiseDelay - colorDelay));
    vec4 finalColor = vec4(mix(color.rgb, vec3(1), 1.0 - progress), 1.0);

    vec4 polaroidColor = texture2D(u_texture_polaroid, uv);
    gl_FragColor = mix(finalColor, polaroidColor, polaroidColor.a);
}
