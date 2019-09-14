precision mediump float;

void main()
{
    // there's a built-in input constant - pixel coordinate
    // it starts from (0, 0) to (width, height) of the canvas
    vec2 coord = gl_FragCoord.xy;

    // another variable (but more like constant)
    float size = 300.0;

    // let's show coordinate with colors
    vec4 color = vec4(coord.x / size, coord.y / size, 1.0, 1.0);

    gl_FragColor = color;
}
