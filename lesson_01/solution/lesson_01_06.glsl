precision mediump float;

void main()
{
    // (1) variables - <type> <name> = <value>;
    vec4 color = vec4(1.0, 1.0, 1.0, 1.0);

    // (3) can change it later:
    color.r = 0.0;

    // (4) can change multiple channels at the same time
    color.rgb = vec3(1.0, 1.0, 0.0);

    // (2) can use it anytime after its declaration
    gl_FragColor = color;
}
