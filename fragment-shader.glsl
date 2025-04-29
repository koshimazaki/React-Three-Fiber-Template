// src/shaders/fragment/myShader.glsl
uniform float uTime;
uniform vec3 uColor;
varying vec2 vUv;

void main() {
  // Create a gradient based on UV coordinates
  vec3 color = mix(uColor, vec3(1.0), vUv.y);
  
  // Add some time-based animation
  float pulse = (sin(uTime * 2.0) + 1.0) * 0.5;
  color = mix(color, vec3(1.0), pulse * 0.2);
  
  gl_FragColor = vec4(color, 1.0);
} 