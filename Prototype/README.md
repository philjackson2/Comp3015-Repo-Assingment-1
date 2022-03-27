# Philip Jackson Comp3015 CW 1
This program makes use of Diffuse, Specular and Ambient shading models with a BlinnPhong function. 
### Version Information
Written in Visual Studio Version 16.11.7 
Targeted for Windows 10 
Configuration type  Application (.exe)
Windows SDK 10.0

### Git link
https://github.com/philjackson2/Comp3015-Repo-Assingment-1.git

### YouTube link
https://youtu.be/hEjBY7uHLTg
### How to Open
Simply go into the folder and click on the .exe file

### What makes it unique
I started off with a diffuse model basis project and began changing how the user interacted with it. I added multiple models, camera controls and keys to change the texture of the objects. 
## User Interaction 
The user uses the A and D keys to control the camera movement direction and the P, L and M keys to change the texture of the objects in the scene. 

## How does it work?

### Shader code

**Ambient**
The way that ambient works is that it gives the scene a set of colours that can be used as shadows 
The formula for how this works is Ia = Ka ∙ La 
Ia = Intensity, Ka = Surface reflectivity , La = Light source intensity 


**Diffuse** 
Diffuse gives a full matte paint feel to the objects with no shiny textures. When the light hits it, it sends it back in one direction. 


**Specular**
Specular gives a shiny look and texture to the models. Based on where you are viewing it from. If you are viewing it from the direction of the light it is most shiny. Unlike diffuse it reflects out in in multiple locations which is what makes it shiny. 
its mathematical formula is Is = Ks ∙ Ls ∙ (r.v)f
Ks - Specular light reflectivity, Ls = Light sensitivity, R = Reflection vector, V = Viewing Vector, F = Power coefficient 

These 3 methods make up the Phong model of shading. 


### .cpp and .h
**.h**

In the .h is where we declare public and private variables and meshes are declared here we declare the individual object meshes so that they do not overwrite each other.

``` std::  std::unique_ptr<ObjMesh> pig;```
defines 'pig' as the name of the mesh which then uses in the CPP


**.cpp**
The CPP is where the bulk of the scene is set up. 

The object meshes defined in the .h file are now loaded in with ``` SceneBasic_Uniform::SceneBasic_Uniform() ``` 
with the following code: 
`` cube = ObjMesh::load("media/cube.obj",
        true);
``

They are then placed into the scene in the void ``SceneBasic_Uniform::render()``with the following code: 
``model = mat4(1.0f);
    model = glm::rotate(model, glm::radians(90.0f), vec3(0.0f, 1.0f, 0.0f));
    setMatrices();
    pig->render();``
    It also defines its position of where it will start out. This is changed through editing its position in the vec3 coordinated. 

This function also houses the camera controls and starting position for the camera.
 ``vec3 cameraPos = vec3(10.0f * cos(angle),x, y * sin(angle));
    view = glm::lookAt(cameraPos, vec3(0.0f, 0.0f, 0.0f), vec3(0.0f, 1.0f,
        0.0f));``
the position works the same way that the models do. 



With the models loaded in the shaders need to be loaded in. This is done in the ``void SceneBasic_Uniform::compile()`` function. 

The lights are position ``void SceneBasic_Uniform::initScene()`` as such
`` prog.setUniform("Lights[0].L", vec3(0.0f, 0.0f, 0.8f));
    prog.setUniform("Lights[1].L", vec3(0.0f, 0.8f, 0.0f));
    prog.setUniform("Lights[2].L", vec3(0.8f, 0.0f, 0.0f));
    prog.setUniform("Lights[0].La", vec3(0.0f, 0.0f, 0.8f));
    prog.setUniform("Lights[1].La", vec3(0.0f, 0.8f, 0.0f));
    prog.setUniform("Lights[2].La", vec3(0.8f, 0.0f, 0.0f));``
    
   
Positioned in the same way that the objects are by defining their position in the axis through the vec 

This function also has the initiation for the base texture 
`` GLuint texID =
        Texture::loadTexture("media/texture/brick1.jpg");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texID);``
    It is taken from the texture file and displayed onto all the objects in the scene.


Finally the ``void SceneBasic_Uniform::update``is where the user interacts with with program using variations of ``if (GetKeyState('A') & 0x8000) `` that pulls from the user pressing that key. 

The A and D keys are used to interact with the camera through 

``  x = 100.f;
        float deltaT = t - tPrev;
        if (tPrev == x)
            deltaT = 10.0f;
        tPrev = t;
        angle += rotSpeed * deltaT;
        if (angle > glm::two_pi<float>())
            angle -= glm::two_pi<float>();``
that makes the camera float through the scene anchored on the centre of the screen.


The D key inverts ``float deltaT = t - tPrev;`` into ``float deltaT = tPrev - t;`` in order to get an opposite effect. 


Finally remaining in this function we have the textures change through button presses by repeating the same way we go the textures in in the scene initiation within a ``GetKeyState`` If statement and changing which texture it grabs. 

REMEMBER TO ADD THIS TO THE ZIP
