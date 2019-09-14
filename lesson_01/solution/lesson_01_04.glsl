precision mediump float;

void main()
{
    // color channel valus should be in range [0.0, 1.0]; if not, it will be clipped
    // try changing color to some other value (cyan?)
    gl_FragColor = vec4(0.0, 1.0, 1.0, 1.0);
}
