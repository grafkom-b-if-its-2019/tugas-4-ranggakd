precision mediump float;

attribute vec3 vPosition;
attribute vec3 vColor;
attribute vec3 vNormal;

varying vec3 fColor;
varying vec3 fPosition;
varying vec3 fNormal;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

uniform mat3 normalMatrix;

uniform float scale;
uniform float center;
uniform vec3 bounce;

void main() {
  mat4 to_origin = mat4(
    1.0, 0.0, 0.0, -0.35,
    0.0, 1.0, 0.0, -0.4,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, -2.0, 1.0
  );

  mat4 bounce = mat4(
    1.0, 0.0, 0.0, bounce.x,
    0.0, 1.0, 0.0, bounce.y,
    0.0, 0.0, 1.0, bounce.z,
    0.0, 0.0, 0.0, 1.0
  );

  vec4 vecCenter = vec4(center,0,0,1.0);

  mat4 skalasi = mat4(
    scale, 0.0, 0.0, -(vecCenter.x)*scale + (vecCenter.x),
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  );

  gl_Position = vec4(vPosition, 1.0) * bounce * skalasi;
  gl_Position = projection * view * to_origin * gl_Position;
  // urutan perkaliannya harus = projection x view x model (transformasi)

  fColor = vColor;
  fPosition = vec3(view * model * vec4(vPosition, 1.0));
  fNormal = normalMatrix * vNormal;
}
