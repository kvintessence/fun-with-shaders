precision mediump float;

uniform sampler2D u_texture_sea;
uniform sampler2D u_texture_perlin_noise;

uniform vec2 u_resolution;
uniform float u_time;

void main()
{
    float SPEED = 0.05;
    float POWER = 0.04;

    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec2 animationCoords = vec2(SPEED * u_time);

    vec2 offset = texture2D(u_texture_perlin_noise, fract(coords + animationCoords), -10.0).rr;
    offset = vec2(1.0) - offset * offset;
    offset = offset - vec2(0.5);

    vec2 coordsWithOffset = (coords + POWER * offset);

    vec4 color = texture2D(u_texture_sea, coordsWithOffset);

    gl_FragColor = color;
}
