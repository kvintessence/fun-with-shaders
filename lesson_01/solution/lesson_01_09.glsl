precision mediump float;

// now let's make animation! introducing uniforms
// uniforms are the same for all fragments (pixels)
uniform float u_time;

void main()
{
    vec4 color1 = vec4(0.0, 1.0, 1.0, 1.0);
    vec4 color2 = vec4(1.0, 1.0, 0.0, 1.0);

    vec2 coord = gl_FragCoord.xy;
    // now use time to make animation (+u_time)
    // float coeff = (1.0 + cos(coord.y / 50.0)) / 2.0;
    float coeff = (1.0 + cos(coord.y / 50.0 + 5.0 * u_time)) / 2.0;

    gl_FragColor = mix(color1, color2, coeff);
}
