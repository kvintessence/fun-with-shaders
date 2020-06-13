precision mediump float;

uniform sampler2D u_texture_town;
uniform sampler2D u_texture_green_screen;
uniform sampler2D u_texture_perlin_noise;

uniform vec2 u_resolution;
uniform float u_time;

#define uv gl_FragCoord.xy / u_resolution.xy

vec4 green_screen_color(sampler2D texture, vec2 coords)
{
    vec4 color = texture2D(texture, coords);

    float COEFF_A = 1.0;
    float COEFF_B = 0.2;

    float maxC = max(max(color.r, color.g), color.b);

    color.a = (COEFF_A * (color.r + color.b) - COEFF_B * color.g) / (maxC + 0.0001);

    if (color.a < 0.99)
        color.rgb = vec3(color.r, min(color.g, color.b), color.b);

    if (color.a > 0.5)
        color.a = 1.0;

    return color;
}

void main()
{
    vec4 bg = texture2D(u_texture_town, uv);
    vec4 character = green_screen_color(u_texture_green_screen, uv);

    vec2 coordTimeOffset =  fract(0.07 * (uv + vec2(u_time * 0.1)));
    vec2 offset = 0.01 * texture2D(u_texture_perlin_noise, coordTimeOffset).rr;
    offset.x += 0.01 * character.r;
    offset.y += 0.01 * character.b;

    vec4 bgWithOffset = texture2D(u_texture_town, fract(uv + fract(offset)));

    vec3 mixed;

    if (character.a > 0.0) {
        mixed = mix(bgWithOffset.rgb, character.rgb, 0.01 * character.a);
        //mixed = mix(vec3(0.0), mixed, 0.91);
    } else {
        mixed = bg.rgb;
    }

    gl_FragColor = vec4(mixed, 1.0);
}
