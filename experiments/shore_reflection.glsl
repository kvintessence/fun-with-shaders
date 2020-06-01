precision mediump float;

uniform sampler2D u_texture_shore;
uniform sampler2D u_texture_perlin_noise;

uniform vec2 u_resolution;
uniform float u_time;

float SPLIT_Y = 0.25;

float WATER_FLOW_SPEED = 0.05;
float WATER_FLOW_POWER = 0.04;
vec2 WATER_FLOW_DIRECTION = vec2(1.0, 0.0);

vec2 coordsWithNoise()
{
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec2 animationCoords = WATER_FLOW_SPEED * u_time * normalize(WATER_FLOW_DIRECTION);

    vec2 offset = texture2D(u_texture_perlin_noise, fract(coords + animationCoords), -10.0).rr;
    offset = vec2(1.0) - offset * offset;
    offset = offset - vec2(0.5);

    return (coords + WATER_FLOW_POWER * offset);
}

void main()
{
    vec2 coords = gl_FragCoord.xy / u_resolution;

    if (coords.y > SPLIT_Y) {
        gl_FragColor = texture2D(u_texture_shore, coords);
        return;
    }

    vec2 coordsWithOffset = coordsWithNoise();
    float waterY = coordsWithOffset.y / SPLIT_Y;
    vec2 coordReflected = vec2(coordsWithOffset.x, SPLIT_Y + 0.5 * (1.0 - waterY) * (1.0 - SPLIT_Y));

    vec4 fromC = vec4(0.4, 0.3, 0.3, 0.2);
    vec4 toC = vec4(0.3, 0.4, 0.5, 1.0);

    vec4 waterColor = mix(fromC, toC, 1.0 - waterY);
    vec4 realColor = texture2D(u_texture_shore, coordReflected);

    vec4 color = vec4(mix(realColor, waterColor, waterColor.a).rgb, 1.0);

    gl_FragColor = color;
}
