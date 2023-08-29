boolean intersection_hitsphere(vec4 pos,vec4 aim, vec4 model_center){
    float A = norm(aim) * norm(aim);
    float B = 2 * dot(aim, (pos - model_center));
    float C = norm(pos - model_center) * norm(pos - model_center) - 10;
    
    float D =  t*t*A + t*B + C;

    return false;
}
