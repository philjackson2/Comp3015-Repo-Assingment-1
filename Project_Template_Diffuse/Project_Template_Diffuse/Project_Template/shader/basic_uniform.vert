#version 460

//in variables, this are in model coordinates
layout (location = 0) in vec3 VertexPosition; 
layout (location = 1) in vec3 VertexNormal; 


//out vector needed for the fragment shader
out vec3 LightIntensity;
out vec3 Colour;



 
 //light information struct
uniform struct LightInfo 
{
  vec4 Position; // Light position in eye coords.
  vec3 La; //Ambient light intesisty
  vec3 L; //diffuse and speccular light intensity
  vec3 Ld;       // Diffuse light intensity
} Lights[3];

//material information struct
uniform struct MaterialInfo 
{
  vec3 Ka; // ambient reflectivity
  vec3 Kd;      // Diffuse reflectivity
  vec3 Ks; //specular reflectivity
  float Shininess; //Specular shininess factor
} Material;

//uniforms for matrices required in the shader
uniform mat4 ModelViewMatrix;   //model view matrix
uniform mat3 NormalMatrix;		//normal matrix
uniform mat4 MVP;				//model view projection matrix

 

 vec3 phongModel( int light, vec4 position, vec3 n ) {
 
 //calcute ambient light to access each light la value
  vec3 ambient = Lights[light].La * Material.Ka;
 
 //calculate diffuse here 

 vec3 s = normalize(vec3(Lights[light].Position) -VertexPosition);

 float SDotN = max(dot(s, n),0.0);

vec3 diffuse = Material.Kd * SDotN;
//calculate specular here
vec3 spec = vec3(0.0); 

if( SDotN > 0.0 )
{
vec3 v = normalize(-position.xyz);
vec3 r = reflect( -s, n ); 
spec = Material.Ks *pow( max ( dot(r,v), 0.0 ), 
Material.Shininess );
}
 return ambient + Lights[light].L * (diffuse + spec); 
 }


void main() 
{ 
  //transfrom normal from model coordinates to view coordinates


  
  vec3 n = normalize( NormalMatrix * VertexNormal);
  vec4 coords = ModelViewMatrix * vec4(VertexPosition, 1.0);

  Colour = vec3(0.0);
for( int i = 0; i < 3; i++ )
{
Colour += phongModel( i, coords, n );
}


  //transform vertex position from model coordinates to view coordinates
//  vec4 pos = ModelViewMatrix * vec4(VertexPosition,1.0);
//
//  //calculate light direction, notice the light is already in the view coordinates 
//  vec3 s = normalize(vec3(Lights#.Position - pos));
//
//  //calculate dot product for vector s and n using max. Read about max in glsl documentation, if not clear talk to me
//  float sDotN = max( dot(s,n), 0.0 );
//
//  //difuse formula for light calculations
//  vec3 diffuse = Light.Ld * Material.Kd * sDotN;

  //pass the colour to LightIntensity which will transfer it to the fragment shader
//  LightIntensity = diffuse;

  //turns any vertex position into model view projection in preparations to 
  //graphics pipeline processes before fragment shader (clipping)
  gl_Position = MVP * vec4(VertexPosition,1.0) ; //*RotationMatrix for roating
} 