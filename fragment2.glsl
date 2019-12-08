precision mediump float;

varying vec3 fNormal;
varying vec3 fPosition;
varying vec2 fTexCoord;

uniform vec3 lightColor;
uniform vec3 lightPosition;
uniform vec3 ambientColor;
// uniform float shininess;

uniform sampler2D sampler0;
// uniform sampler2D sampler1;
// uniform sampler2D sampler2;
// uniform sampler2D sampler3;
// uniform sampler2D sampler4;

// http://learnwebgl.brown37.net/09_lights/lights_combined.html?highlight=diffuse

void main() {

  vec4 tex0 = texture2D(sampler0, fTexCoord); // Hasil akhirnya adalah warna (RGBA)

  vec3 ambient = ambientColor * vec3(tex0);

  vec3 lightDirection = lightPosition - fPosition;
  lightDirection = normalize(lightDirection);

  vec3 normal = normalize(fNormal);
  
  float lightIntensity = max(dot(-normal, lightDirection), 0.0);
  
  float specPower = 120.;
  float spec = 0.;

  if(lightIntensity > 0.0){
    vec3 view = vec3(0, 0, 1.0);
    vec3 reflection = reflect(-lightDirection, normal);
    float specFactor = max(dot(reflection,view),0.);
    spec = pow(specFactor,specPower);
  }

  vec3 diffuse = lightColor * vec3(tex0) * lightIntensity + spec;

  gl_FragColor = vec4(ambient + diffuse, 1.0);
}
