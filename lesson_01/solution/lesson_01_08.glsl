precision mediump float;

void main()
{
    // (1) let's make a 'gradient' stuff; first we need two colors
    vec4 color1 = vec4(0.0, 1.0, 1.0, 1.0);
    vec4 color2 = vec4(1.0, 1.0, 0.0, 1.0);

    // (2) coord
    vec2 coord = gl_FragCoord.xy;

    // (3) now let's create a function [0.0, 1.0]
    // https://www.desmos.com/calculator
    // float coeff = (1.0 + cos(coord.y)) / 2.0;

    // (5) not good - divite coord
    float coeff = (1.0 + cos(coord.y / 50.0)) / 2.0;

    // (4) now let's mix colors
    gl_FragColor = mix(color1, color2, coeff);
}
