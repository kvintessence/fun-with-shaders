float SPLIT_Y = 0.23;

float WATER_FLOW_SPEED = 0.05;
float WATER_FLOW_POWER = 0.04;
vec2 WATER_FLOW_DIRECTION = vec2(-1.0, -1.0);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 coords = fragCoord / iResolution.xy;
    vec2 animationCoords = WATER_FLOW_SPEED * iTime * normalize(WATER_FLOW_DIRECTION);

    vec2 offset = texture(iChannel1, fract(coords + animationCoords), -10.0).rr;
    offset = vec2(1.0) - offset * offset;
    offset = offset - vec2(0.5);
    vec2 coordsWithOffset = (coords + WATER_FLOW_POWER * offset);

    if (coords.y > SPLIT_Y) {
        fragColor = texture(iChannel0, coords);
        return;
    }

    float waterY = coordsWithOffset.y / SPLIT_Y;
    vec2 coordReflected = vec2(coordsWithOffset.x, SPLIT_Y + 0.5 * (1.0 - waterY) * (1.0 - SPLIT_Y));

    vec4 fromC = vec4(0.4, 0.3, 0.3, 0.2);
    vec4 toC = vec4(0.3, 0.4, 0.5, 1.0);

    vec4 waterColor = mix(fromC, toC, 1.0 - waterY);
    vec4 realColor = texture(iChannel0, coordReflected);

    vec4 color = vec4(mix(realColor, waterColor, waterColor.a).rgb, 1.0);

    fragColor = color;
}