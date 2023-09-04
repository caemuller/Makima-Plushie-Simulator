
// returns max of 3 numbers
float max3(float v1, float v2, float v3){
    if(v1 < 0)
        v1 = -v1;

    if(v2 < 0)
        v2 = -v2;

    if(v3 < 0)
        v3 = -v3;

    if(v1 >= v2 && v1 >= v3){
        return v1;
    }
    else if(v2 >= v1 && v2 >= v3){
        return v2;
    }
    else{
        return v3;
    }
}
// collision test between box and box
bool BoxCollision(const glm::vec3 bbox1min, const glm::vec3 bbox1max, const glm::vec3 bbox2min, const glm::vec3 bbox2max) {

    bool collisionX = bbox1max.x >= bbox2min.x && bbox2max.x >= bbox1min.x;
    bool collisionY = bbox1max.y >= bbox2min.y && bbox2max.y >= bbox1min.y;
    bool collisionZ = bbox1max.z >= bbox2min.z && bbox2max.z >= bbox1min.z;

    return collisionX && collisionY && collisionZ;
}


bool CheckSphereCollision(const glm::vec3 centroeu, const glm::vec3 centroobj, const float radius1, const float radius2) {


    bool condition1 = (centroeu.x - centroobj.x) <= (radius1 + radius2);
    bool condition2 = (centroeu.y - centroobj.y) <= (radius1 + radius2);
    bool condition3 = (centroeu.z - centroobj.z) <= (radius1 + radius2);

    if(condition1 && condition2 && condition3){
        return true;
    }
    else{
        return false;
    }
}

// collision test between cillinder and cillinder
bool CheckCillinderCollision(const glm::vec3 bbox1min, const glm::vec3 bbox1max, const glm::vec3 bbox2min, const glm::vec3 bbox2max) {
    float meanx1 = (bbox1min.x + bbox1max.x)/2;
    float meany1 = (bbox1min.y + bbox1max.y)/2;
    float meanz1 = (bbox1min.z + bbox1max.z)/2;

    float meanx2 = (bbox2min.x + bbox2max.x)/2;
    float meany2 = (bbox2min.y + bbox2max.y)/2;
    float meanz2 = (bbox2min.z + bbox2max.z)/2;

    glm::vec3 center_cillinder1 = glm::vec3(meanx1, meany1, meanz1);
    glm::vec3 center_cillinder2 = glm::vec3(meanx2, meany2, meanz2);

    float radius1 = max3(bbox1max.x - bbox1min.x, bbox1max.z - bbox1min.z, 0);
    float radius2 = max3(bbox2max.x - bbox2min.x, bbox2max.z - bbox2min.z, 0);

    bool condition1 = (center_cillinder1.x - center_cillinder2.x) <= (radius1 + radius2);
    bool condition2 = (center_cillinder1.y - center_cillinder2.y) <= (radius1 + radius2);
    bool condition3 = (center_cillinder1.z - center_cillinder2.z) <= (radius1 + radius2);

    if(condition1 && condition2 && condition3){
        return true;
    }
    else{
        return false;
    }
}

// collision test between cillinder and tree
bool CheckCillinderCollisionTree(const glm::vec3 bbox1min, const glm::vec3 bbox1max, const glm::vec3 center_tree, const float radius_tree) {
    float meanx1 = (bbox1min.x + bbox1max.x)/2;
    float meany1 = (bbox1min.y + bbox1max.y)/2;
    float meanz1 = (bbox1min.z + bbox1max.z)/2;

    glm::vec3 center_cillinder1 = glm::vec3(meanx1, meany1, meanz1);

    float radius1 = max3(bbox1max.x - bbox1min.x, bbox1max.z - bbox1min.z, 0);

    bool condition1 = (center_cillinder1.x - center_tree.x) <= (radius1 + radius_tree);
    bool condition3 = (center_cillinder1.z - center_tree.z) <= (radius1 + radius_tree);

    if(condition1  && condition3){
        return true;
    }
    else{
        return false;
    }
}

// collision test between dot and box
bool CheckDotBox(const glm::vec3 dot, const glm::vec3 bboxmin, const glm::vec3 bboxmax) {
    bool condition1 = dot.x >= bboxmin.x && dot.x <= bboxmax.x;
    bool condition2 = dot.y >= bboxmin.y && dot.y <= bboxmax.y;
    bool condition3 = dot.z >= bboxmin.z && dot.z <= bboxmax.z;

    if(condition1 && condition2 && condition3){
        return true;
    }
    else{
        return false;
    }
}

// collision test between dots
bool CheckDotDot(const glm::vec3 dot1, const glm::vec3 dot2, const float radius1, const float radius2) {
    bool condition1 = (dot1.x - dot2.x) <= (radius1 + radius2);
    bool condition2 = (dot1.y - dot2.y) <= (radius1 + radius2);
    bool condition3 = (dot1.z - dot2.z) <= (radius1 + radius2);

    if(condition1 && condition2 && condition3){
        return true;
    }
    else{
        return false;
    }
}

// bool spherical_collision(glm::vec3 pos1, glm::vec3 pos2, float r1, float r2){
//     if(norm(pos1 - pos2) <= (r1 + r2)){
//         return true;
//     }
//     else{
//         return false;
//     }
// }