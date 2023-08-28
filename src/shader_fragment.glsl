#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;
in vec4 light_source;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;


// Identificador que define qual objeto está sendo desenhado no momento
#define SPHERE 0
#define BUNNY  1
#define PLANE  2
#define SKYSPHERE 3
#define MOON 4
uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;

// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923

void main()
{
    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(vec4(11.0,10.0,111.0,0.0));
    // vec4 l = normalize(light_source - position_world);

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    // Vetor que define o sentido da reflexão especular ideal.
    // vec4 r = vec4(0.0,0.0,0.0,0.0); // PREENCHA AQUI o vetor de reflexão especular ideal
    vec4 r = normalize(-l + 2 * n * dot(n, l));

    vec3 Kd; // Refletância difusa
    vec3 Ks; // Refletância especular
    vec3 Ka; // Refletância ambiente
    float q; // Expoente especular para o modelo de iluminação de Phong

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;
    vec3 Kd0 = vec3(0.0,0.0,0.0);
    float epsilon = 0.0001;

    if ( object_id == SPHERE )
    {
        // PREENCHA AQUI as coordenadas de textura da esfera, computadas com
        // projeção esférica EM COORDENADAS DO MODELO. Utilize como referência
        // o slides 134-150 do documento Aula_20_Mapeamento_de_Texturas.pdf.
        // A esfera que define a projeção deve estar centrada na posição
        // "bbox_center" definida abaixo.

        // Você deve utilizar:
        //   função 'length( )' : comprimento Euclidiano de um vetor
        //   função 'atan( , )' : arcotangente. Veja https://en.wikipedia.org/wiki/Atan2.
        //   função 'asin( )'   : seno inverso.
        //   constante M_PI
        //   variável position_model

        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;
        
        vec4 p_l = bbox_center + 11* ((position_model - bbox_center)/(length(position_model - bbox_center)));
        vec4 p_v = p_l - bbox_center;        

        
        float theta = atan(p_v.x, p_v.z) + epsilon;
        float phi = asin(p_v.y/11) + epsilon;; 

        Ks = vec3(0.2,0.2,0.2);
        q = 1.0;
        

        U = (theta + M_PI)/(2*M_PI);        
        V = (phi + (M_PI_2))/(M_PI);
        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        Kd0 = texture(TextureImage1, vec2(U,V)).rgb;
        Ka = Kd0 / 2.0f;
        
        
        
    }
    else if ( object_id == BUNNY )
    {
        // PREENCHA AQUI as coordenadas de textura do coelho, computadas com
        // projeção planar XY em COORDENADAS DO MODELO. Utilize como referência
        // o slides 99-104 do documento Aula_20_Mapeamento_de_Texturas.pdf,
        // e também use as variáveis min*/max* definidas abaixo para normalizar
        // as coordenadas de textura U e V dentro do intervalo [0,1]. Para
        // tanto, veja por exemplo o mapeamento da variável 'p_v' utilizando
        // 'h' no slides 158-160 do documento Aula_20_Mapeamento_de_Texturas.pdf.
        // Veja também a Questão 4 do Questionário 4 no Moodle.

        float minx = bbox_min.x;
        float maxx = bbox_max.x;

        float miny = bbox_min.y;
        float maxy = bbox_max.y;

        float minz = bbox_min.z;
        float maxz = bbox_max.z;

        float X = (position_model.x - bbox_min.x)/(bbox_max.x - bbox_min.x);
        float Y = (position_model.y - bbox_min.y)/(bbox_max.y - bbox_min.y);

        Ks = vec3(0.3,0.3,0.3);
        Ka = vec3(0.2,0.2,0.2);
        q = 20.0;

        U = X;
        V = Y;
        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        Kd0 = texture(TextureImage3, vec2(U,V)).rgb;

    }
    else if ( object_id == PLANE )
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x *100;
        V = texcoords.y * 100;
        // Kd = vec3(0.2,0.2,0.2);
        Ks = vec3(0.3,0.3,0.3);
        Ka = vec3(0.2,0.2,0.2);
        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        Kd0 = texture(TextureImage2, vec2(U,V)).rgb;
    }
    else if ( object_id == SKYSPHERE )
    {
        // PREENCHA AQUI as coordenadas de textura da esfera, computadas com
        // projeção esférica EM COORDENADAS DO MODELO. Utilize como referência
        // o slides 134-150 do documento Aula_20_Mapeamento_de_Texturas.pdf.
        // A esfera que define a projeção deve estar centrada na posição
        // "bbox_center" definida abaixo.

        // Você deve utilizar:
        //   função 'length( )' : comprimento Euclidiano de um vetor
        //   função 'atan( , )' : arcotangente. Veja https://en.wikipedia.org/wiki/Atan2.
        //   função 'asin( )'   : seno inverso.
        //   constante M_PI
        //   variável position_model

        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;
        
        vec4 p_l = bbox_center + 11* ((position_model - bbox_center)/(length(position_model - bbox_center)));
        vec4 p_v = p_l - bbox_center;        

        
        float theta = atan(p_v.x, p_v.z) + epsilon;
        float phi = asin(p_v.y/11) + epsilon; 
        
        // U = (theta + M_PI)/(2*M_PI);

        U = (theta < 0.0) ? (theta + 2.0 * M_PI) : theta;
        U /= (2.0 * M_PI);


        V = (phi + (M_PI_2))/(M_PI);
        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        Kd0 = texture(TextureImage0, vec2(U,V)).rgb;        
        
        
    }
    else if ( object_id == MOON )
    {
        // PREENCHA AQUI as coordenadas de textura da esfera, computadas com
        // projeção esférica EM COORDENADAS DO MODELO. Utilize como referência
        // o slides 134-150 do documento Aula_20_Mapeamento_de_Texturas.pdf.
        // A esfera que define a projeção deve estar centrada na posição
        // "bbox_center" definida abaixo.

        // Você deve utilizar:
        //   função 'length( )' : comprimento Euclidiano de um vetor
        //   função 'atan( , )' : arcotangente. Veja https://en.wikipedia.org/wiki/Atan2.
        //   função 'asin( )'   : seno inverso.
        //   constante M_PI
        //   variável position_model

        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;
        
        vec4 p_l = bbox_center + 11* ((position_model - bbox_center)/(length(position_model - bbox_center)));
        vec4 p_v = p_l - bbox_center;        

        
        float theta = atan(p_v.x, p_v.z) + epsilon;
        float phi = asin(p_v.y/11) + epsilon; 
        
        U = (theta + M_PI)/(2*M_PI);        
        V = (phi + (M_PI_2))/(M_PI);
        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        Kd0 = texture(TextureImage0, vec2(U,V)).rgb;        
        
        
    }


   // Espectro da fonte de iluminação
    vec3 I = vec3(1.0,1.0,1.0); // PREENCH AQUI o espectro da fonte de luz

    // Espectro da luz ambiente
    vec3 Ia = vec3(0.2,0.2,0.2); // PREENCHA AQUI o espectro da luz ambiente

    // Termo difuso utilizando a lei dos cossenos de Lambert
    vec3 lambert_diffuse_term = Kd * I * max(0, dot(n, l)); // PREENCHA AQUI o termo difuso de Lambert

    // Termo ambiente
    vec3 ambient_term = Ka * Ia; // PREENCHA AQUI o termo ambiente

    // Termo especular utilizando o modelo de iluminação de Phong
    vec3 phong_specular_term  = Ks * I * pow(max(0, dot(r, v)), q); // PREENCH AQUI o termo especular de Phong

    vec4 h = normalize(l + v);

    vec3 blinn_phong_specular_term  = Ks * I * pow(max(0, dot(h, n)), q); // PREENCH AQUI o termo especular de Blinn-Phong

    // NOTE: Se você quiser fazer o rendering de objetos transparentes, é
    // necessário:
    // 1) Habilitar a operação de "blending" de OpenGL logo antes de realizar o
    //    desenho dos objetos transparentes, com os comandos abaixo no código C++:
    //      glEnable(GL_BLEND);
    //      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    // 2) Realizar o desenho de todos objetos transparentes *após* ter desenhado
    //    todos os objetos opacos; e
    // 3) Realizar o desenho de objetos transparentes ordenados de acordo com
    //    suas distâncias para a câmera (desenhando primeiro objetos
    //    transparentes que estão mais longe da câmera).
    // Alpha default = 1 = 100% opaco = 0% transparente
    color.a = 1;

    // Cor final do fragmento calculada com uma combinação dos termos difuso,
    // especular, e ambiente. Veja slide 129 do documento Aula_17_e_18_Modelos_de_Iluminacao.pdf.
    color.rgb = lambert_diffuse_term + ambient_term + phong_specular_term;
    
    
    if(object_id == SKYSPHERE || object_id == MOON){
        
        color.rgb = Kd0 ;
        if(MOON == object_id){
            color.g *= 1.5;
            color.r *= 1.5;

        }
    }
    else{
        // Equação de Iluminação
        lambert_diffuse_term = Kd0 * I * max(0, dot(n, l));
        vec3 phong_specular_term  = Ks * I * pow(max(0, dot(r, v)), q);
        vec3 blinn_phong_specular_term  = Ks * I * pow(max(0, dot(h, n)), q);

        float lambert = max(0,dot(n,l));
        // color.rgb = (Kd0 * (lambert + 0.01));
        color.rgb = Kd0 * (lambert_diffuse_term + ambient_term + blinn_phong_specular_term);

    }

    // NOTE: Se você quiser fazer o rendering de objetos transparentes, é
    // necessário:
    // 1) Habilitar a operação de "blending" de OpenGL logo antes de realizar o
    //    desenho dos objetos transparentes, com os comandos abaixo no código C++:
    //      glEnable(GL_BLEND);
    //      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    // 2) Realizar o desenho de todos objetos transparentes *após* ter desenhado
    //    todos os objetos opacos; e
    // 3) Realizar o desenho de objetos transparentes ordenados de acordo com
    //    suas distâncias para a câmera (desenhando primeiro objetos
    //    transparentes que estão mais longe da câmera).
    // Alpha default = 1 = 100% opaco = 0% transparente
    color.a = 1;

    // Cor final com correção gamma, considerando monitor sRGB.
    // Veja https://en.wikipedia.org/w/index.php?title=Gamma_correction&oldid=751281772#Windows.2C_Mac.2C_sRGB_and_TV.2Fvideo_standard_gammas
    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);
} 
