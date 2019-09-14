precision mediump float;

uniform sampler2D u_texture_pumpkin;
uniform sampler2D u_texture_pumpkin_normal;

uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main()
{
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec4 color = texture2D(u_texture_pumpkin, coords);
    vec3 normal = normalize(2.0 * texture2D(u_texture_pumpkin_normal, coords).xyz - 1.0);

    vec3 lightDirection = vec3(0.0, 0.0, 5.0) +
         vec3(10.0 * (u_mouse / u_resolution - 0.5), 0.0);
    lightDirection = normalize(lightDirection);

    float luminance = (dot(normal, lightDirection));
    vec3 final = mix(vec3(0.0), color.rgb, luminance);

    if (u_mouse.x > gl_FragCoord.x) {
        gl_FragColor = vec4(final, color.a);
    } else {
        gl_FragColor = vec4(color.rgb, color.a);
    }
}
