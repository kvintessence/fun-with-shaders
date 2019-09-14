precision mediump float;

uniform sampler2D u_texture_birds;
uniform sampler2D u_texture_perlin_noise;

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

void main()
{
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec4 color = texture2D(u_texture_birds, coords);
 
    float condition = u_mouse.x / u_resolution.x;
    float stainStart = texture2D(u_texture_perlin_noise, coords).r;
    float stainEnd = stainStart - 0.2;

    if (stainEnd > condition)
        discard;

    if (condition > stainStart) {
        gl_FragColor = color;
        return;
    }

    vec3 stainColor = vec3(0.0, 1.0, 1.0);

    // last!
    if (condition > stainStart - 0.05) {
        float blend = map(condition, stainStart - 0.05, stainStart, 1.0, 0.0);
        gl_FragColor = vec4((1.0 - blend) * color.rgb + 
            blend * stainColor, color.a);
        return;
    }

    float damageLevel = map(condition, stainStart, stainEnd, 0.0, 1.0);
    damageLevel = 1.0 - damageLevel * damageLevel;

    gl_FragColor = vec4(stainColor, damageLevel);
}
