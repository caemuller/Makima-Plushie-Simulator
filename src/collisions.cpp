bool intersection_hitsphere(glm::vec4 pos,glm::vec4 aim, glm::vec4 model_center, float far){
    
    float r = 10;
    float A = norm(aim) * norm(aim);
    float B = 2 * dot(aim, (pos - model_center));
    float C = norm(pos - model_center) * norm(pos - model_center) - r;

    float t;
    if(0 == t*t*A + t*B + C){
        return true;
    }
    else{
        return false;
    }
}
