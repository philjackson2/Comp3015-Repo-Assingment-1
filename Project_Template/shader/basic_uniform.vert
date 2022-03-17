#version 460

layout (location = 0) in vec3 VertexPosition;
layout (location = 1) in vec3 VertexColor;

out vec3 Color;
uniform mat4 RotationMatrix;



in vec3 Position;
in vec3 VertexNormal; 

out vec3 LightIntensity;


uniform vec4 LightPosition; 

uniform vec3 Kd;

uniform vec3 Ld; 

uniform mat4 ModelViewMatrix;

uniform mat3 NormalMatrix;

uniform mat4 MVP;

void main()
{

    Color = VertexColor;
    gl_Position = RotationMatrix * vec4(Position,1.0);

    vec3 n = normalize( NormalMatrix * VertexNormal);

    LightPosition = normalize (ModelViewMatrix * vec4(VertexPosition,1.0));

    vec4 direction = normalize (LightPosition - VertexPosition);

   
   float LightIntensity = max(dot( direction,n), 0.0);
    
}
