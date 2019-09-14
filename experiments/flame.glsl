precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;

uniform sampler2D u_texture_circle_mask;
uniform sampler2D u_texture_perlin_noise;

vec3 getFlameColor() {
    return vec3(1.0, 0.5, 0.0);
}

float easeOutCubic(float alpha) {
    float t = alpha;
    float b = 0.0;
    float c = 1.0;
    float d = 1.0;

    t /= d;
    return c*t*t*t*t + b;
}

void main() {
    vec2 coords = gl_FragCoord.xy / u_resolution;
    vec2 uvNoise = coords;
    uvNoise.y -= 0.5 * u_time;
    uvNoise.x += 0.2 * sin(1.5 * u_time);
    vec4 colorNoise = texture2D(u_texture_perlin_noise, 0.5 * uvNoise);

    vec4 colorGradient = vec4(1.0, 1.0, 1.0, 1.0);
    colorGradient *= (1.0 - coords.y);

    gl_FragColor = (colorNoise.r + colorGradient) * 1.5 * colorGradient;
    // gl_FragColor = grayscale(gl_FragColor);

    // apply easing
    float alpha = gl_FragColor.r;
    // gl_FragColor *= 1.0 / gl_FragColor.a;
    gl_FragColor *= easeOutCubic(alpha);

    // // ?????
    gl_FragColor.rgb = vec3(gl_FragColor.a, gl_FragColor.a, gl_FragColor.a);

    // apply real color
    vec3 realColor = getFlameColor();
    gl_FragColor = vec4(realColor * gl_FragColor.r, gl_FragColor.a);

    // // apply mask?
    vec4 colorMask = texture2D(u_texture_circle_mask, coords);
    gl_FragColor *= colorMask.a;

    // alphaTest();
}
