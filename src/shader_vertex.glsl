#version 330 core

// Atributos de vértice recebidos como entrada ("in") pelo Vertex Shader.
// Veja a função BuildTrianglesAndAddToVirtualScene() em "main.cpp".
layout (location = 0) in vec4 model_coefficients;
layout (location = 1) in vec4 normal_coefficients;
layout (location = 2) in vec2 texture_coefficients;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform vec4 light_source;
uniform int rasterization_type;


// Atributos de vértice que serão gerados como saída ("out") pelo Vertex Shader.
// ** Estes serão interpolados pelo rasterizador! ** gerando, assim, valores
// para cada fragmento, os quais serão recebidos como entrada pelo Fragment
// Shader. Veja o arquivo "shader_fragment.glsl".
out vec4 position_world;
out vec4 position_model;
out vec4 normal;
out vec2 texcoords;
out vec4 color_v;

void main()
{
    // A variável gl_Position define a posição final de cada vértice
    // OBRIGATORIAMENTE em "normalized device coordinates" (NDC), onde cada
    // coeficiente estará entre -1 e 1 após divisão por w.
    // Veja {+NDC2+}.
    //
    // O código em "main.cpp" define os vértices dos modelos em coordenadas
    // locais de cada modelo (array model_coefficients). Abaixo, utilizamos
    // operações de modelagem, definição da câmera, e projeção, para computar
    // as coordenadas finais em NDC (variável gl_Position). Após a execução
    // deste Vertex Shader, a placa de vídeo (GPU) fará a divisão por W. Veja
    // slides 41-67 e 69-86 do documento Aula_09_Projecoes.pdf.

    gl_Position = projection * view * model * model_coefficients;

    // Como as variáveis acima  (tipo vec4) são vetores com 4 coeficientes,
    // também é possível acessar e modificar cada coeficiente de maneira
    // independente. Esses são indexados pelos nomes x, y, z, e w (nessa
    // ordem, isto é, 'x' é o primeiro coeficiente, 'y' é o segundo, ...):
    //
    //     gl_Position.x = model_coefficients.x;
    //     gl_Position.y = model_coefficients.y;
    //     gl_Position.z = model_coefficients.z;
    //     gl_Position.w = model_coefficients.w;
    //

    // Agora definimos outros atributos dos vértices que serão interpolados pelo
    // rasterizador para gerar atributos únicos para cada fragmento gerado.

    // Posição do vértice atual no sistema de coordenadas global (World).
    position_world = model * model_coefficients;

    // Posição do vértice atual no sistema de coordenadas local do modelo.
    position_model = model_coefficients;

    // Normal do vértice atual no sistema de coordenadas global (World).
    // Veja slides 123-151 do documento Aula_07_Transformacoes_Geometricas_3D.pdf.
    normal = inverse(transpose(model)) * normal_coefficients;
    normal.w = 0.0;

    // Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
    texcoords = texture_coefficients;

    
    //rasterizado
    
    if(rasterization_type == 1)
    {
    // Espectro da fonte de iluminação
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;
    vec4 l = normalize(light_source - position_world);
    vec4 n = normalize(normal);
    vec4 v = normalize(camera_position - position_world);
    vec4 r = normalize(-l + 2 * n * dot(n, l));
    float q = 1.0; // Expoente especular para o modelo de iluminação de Phong
   
    vec3 Kd = vec3(0.3, 0.3, 0.3);
    vec3 Ka = vec3(0.3, 0.3, 0.3);
    vec3 Ks = vec3(0.3, 0.3, 0.3);
    vec3 I = vec3(1.0,1.0,1.0);
    if(light_source.y < 0) {
        if(1/(-light_source.y) >= 0){
            I = vec3(1.0,1.0,1.0)/((-light_source.y/5)+1);
        }
        else{
            I= vec3(0.0,0.0,0.0); // PREENCH AQUI o espectro da fonte de luz
        }
    }
    // Espectro da luz ambiente
    vec3 Ia = vec3(0.2,0.2,0.2); // PREENCHA AQUI o espectro da luz ambiente
    

    // Termo difuso utilizando a lei dos cossenos de Lambert
    vec3 lambert_diffuse_term =  Kd * I * max(0, dot(n, l)); // PREENCHA AQUI o termo difuso de Lambert

    // Termo ambiente
    vec3 ambient_term = Ka * Ia; // PREENCHA AQUI o termo ambiente

    // Termo especular utilizando o modelo de iluminação de Phong
    vec3 phong_specular_term  = Ks * I * pow(max(0, dot(r, v)), q); // PREENCH AQUI o termo especular de Phong

    vec4 h = normalize(l + v);

    vec3 blinn_phong_specular_term  = Ks * I * pow(max(0, dot(h, n)), q); // PREENCH AQUI o termo especular de Blinn-Phong

    
    color_v.a = 1;
    if(light_source.y < 0)
        color_v.rgb = (lambert_diffuse_term + ambient_term + blinn_phong_specular_term/((-light_source.y)+1));
    else
        color_v.rgb = (lambert_diffuse_term + ambient_term + blinn_phong_specular_term);
    
    }

}

