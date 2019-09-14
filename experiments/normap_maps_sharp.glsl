precision mediump float;

uniform sampler2D u_texture_pumpkin;
uniform sampler2D u_texture_pumpkin_normal;

uniform vec2 u_resolution;
uniform vec2 u_mouse;

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
    vec2 tex = textureCoords(vec2(440.0, 360.0), true);
    vec4 color = texture2D(u_texture_pumpkin, tex);
    vec3 normal = normalize(2.0 * texture2D(u_texture_pumpkin_normal, tex).xyz - 1.0);

    /*
    float x = -(2.0 * coords.x - 1.0);
    float y = -(2.0 * coords.y - 1.0);
    float z = max(abs(x), abs(y));
    vec3 normal = normalize(vec3(0.0, 0.0, 1.0) - vec3(x, y, z));
    */

    vec3 lightDirection = vec3(0.0, 0.0, 5.0) +
         vec3(10.0 * (u_mouse / u_resolution - 0.5), 0.0);
    lightDirection = normalize(lightDirection);

    float luminance = dot(normal, lightDirection);
    vec3 final = mix(vec3(0.0), color.rgb, luminance);

    // if (u_mouse.x > gl_FragCoord.x) {
        gl_FragColor = vec4(final, color.a);
    // } else {
        // gl_FragColor = vec4(color.rgb, color.a);
    // }
}
