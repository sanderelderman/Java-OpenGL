#version 400 core
// *********************************************************************************************************************

layout ( triangles ) in;
layout ( triangle_strip, max_vertices = 3) out;

in vec3 passColor[];
in vec3 surfaceNormal[];
in vec3 toLightVector[];

uniform vec3 lightDirection; // direction from the light to the surface
uniform vec3 lightColor;

out vec3 finalColor;
out float passBrightness;

void main() {
    vec3 resultColor = (passColor[0] + passColor[1] + passColor[2]) / 3;
    vec3 resultNormal = (surfaceNormal[0] + surfaceNormal[1] + surfaceNormal[2]) / 3;
    vec3 resultToLight = (toLightVector[0] + toLightVector[1] + toLightVector[2]) / 3;

    vec3 unitNormal = normalize(resultNormal);
    vec3 unitLight = normalize(resultToLight);

    float nDotL = dot(unitLight, unitNormal);
//    float brightness = max(nDotL, 0.3);
    float brightness = (max(nDotL, 0) / 2) + 0.25;


    gl_Position = gl_in[0].gl_Position;
    finalColor = resultColor;
    passBrightness = brightness;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    finalColor = resultColor;
    passBrightness = brightness;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    finalColor = resultColor;
    passBrightness = brightness;
    EmitVertex();

    EndPrimitive();
}