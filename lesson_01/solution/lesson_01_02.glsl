// don't mind this; just a specifier for an openGL
precision mediump float;

// a main function that will be called for an each fragment (pixel)
void main()
{
    // `gl_FragColor` is an output variable that should hold the color
    // of this fragment (pixel) - a vector of 4 values - red, green, blue and alpha
    // to create a vector we call its constructor:
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);

    // there are many data types in GLSL:
    // float, vec2, vec3, vec4, ...
}
