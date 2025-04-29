// src/shaders/vertex/myShader.glsl
uniform float uTime;
varying vec2 vUv;

void main() {
  vUv = uv;
  
  // Simple vertex animation
  vec3 pos = position;
  pos.y += sin(pos.x * 10.0 + uTime) * 0.1;
  
  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
} 