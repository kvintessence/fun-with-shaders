precision mediump float;

uniform sampler2D u_texture_boom;
uniform vec2 u_resolution;
uniform float u_time;

float map(float value, float input1, float input2, float output1, float output2)
{
    float coeff = (value - input1) / (input2 - input1);
    return output1 + coeff * (output2 - output1);
}

vec2 map(vec2 value, vec2 input1, vec2 input2, vec2 output1, vec2 output2)
{
    return vec2(map(value.x, input1.x, input2.x, output1.x, output2.x),
                map(value.y, input1.y, input2.y, output1.y, output2.y));
}

vec2 textureCoords(vec2 size, bool discardExtra)
{
    vec2 screenCenter = 0.5 * u_resolution;
    vec2 halfSize = 0.5 * size;
    vec2 topLeft = screenCenter - halfSize;
    vec2 bottomRight = screenCenter + halfSize;

    vec2 coords = gl_FragCoord.xy;

    if (discardExtra && (topLeft.x > coords.x 
                      || topLeft.y > coords.y 
                      || bottomRight.x < coords.x
                      || bottomRight.y < coords.y))
        discard;

    return map(coords, topLeft, bottomRight, vec2(0.0), vec2(1.0));
}

void main()
{
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec4 color = texture2D(u_texture_boom, textureCoords(vec2(256.0), true));

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
