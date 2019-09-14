precision mediump float;

void main()
{
    // there are several ways to create a vector (and to get its components)
    // gl_FragColor = vec4(vec3(0.0, 1.0, 1.0), 1.0);

    // can specify components
    // gl_FragColor = vec4(vec3(0.0, 1.0, 1.0).rgb, 1.0);

    // can put components in any order
    // gl_FragColor = vec4(vec3(0.0, 1.0, 1.0).bgr, 1.0);

    // can repeat components
    // gl_FragColor = vec4(vec3(0.0, 1.0, 1.0).bbb, 1.0);

    // can make vectors of any length
    // gl_FragColor = vec2(0.0, 1.0).rggg;

    // can't use non-existent component
    gl_FragColor = vec2(0.0, 1.0).rggb;
}
