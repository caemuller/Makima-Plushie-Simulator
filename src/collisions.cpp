float derivada_esfera(float t, float A, float B, float C){
    return ((t + 0.001)*(t + 0.001)*A + (t + 0.001)*B + C) - (t*t*A + t*B + C);
}

bool intersection_hitsphere(glm::vec4 pos,glm::vec4 aim, glm::vec4 model_center, float far){
    
    /*float r = 10;
    float A = norm(aim) * norm(aim);
    float B = 2 * dot(aim, (pos - model_center));
    float C = norm(pos - model_center) * norm(pos - model_center) - r;

    float t;
    float t1 = 0;
    float t2 = far;
    
    while( d1*d2 < 0){
        t = (t1 + t2)/2;
        float d1 = derivada_esfera(t1,A,B,C);    
        float d2 = derivada_esfera(t2,A,B,C);
        float dt = derivada_esfera(t,A,B,C);
        if(t*t*A + t*B+C < 0.001)
            return  true;
        if(dt*d1 < 0)
            t2 = t;
        else if(dt*d2 < 0)
            t1 = t;
    }*/
    return false;
}

bool intersection_hitbox(glm::vec4 pos,glm::vec4 aim, glm::vec3 bbox_min, glm::vec3 bbox_max){
    
    return false;
}


bool intersection_raio(glm::vec4 obj_a, glm::vec4 obj_b, float raio_a, float raio_b){
    if(norm(obj_a - obj_b) <= (raio_a + raio_b)){
        return true;
    }
    else{
        return false;
    }
}



