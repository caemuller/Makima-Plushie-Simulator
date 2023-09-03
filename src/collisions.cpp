
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

bool BoxCollision(const glm::vec3 bbox1min, const glm::vec3 bbox1max, const glm::vec3 bbox2min, const glm::vec3 bbox2max) {

    bool collisionX = bbox1max.x >= bbox2min.x/4 && bbox2max.x/4 >= bbox1min.x;
    bool collisionY = bbox1max.y >= bbox2min.y && bbox2max.y >= bbox1min.y;
    bool collisionZ = bbox1max.z >= bbox2min.z/4 && bbox2max.z/4 >= bbox1min.z;

    return collisionX && collisionY && collisionZ;
}


bool CheckSphereCollision(const glm::vec3 bbox1min, const glm::vec3 bbox1max, const glm::vec3 bbox2min, const glm::vec3 bbox2max) {
    float meanx1 = (bbox1min.x + bbox1max.x)/2;
    float meany1 = (bbox1min.y + bbox1max.y)/2;
    float meanz1 = (bbox1min.z + bbox1max.z)/2;

    float meanx2 = (bbox2min.x + bbox2max.x)/2;
    float meany2 = (bbox2min.y + bbox2max.y)/2;
    float meanz2 = (bbox2min.z + bbox2max.z)/2;

    glm::vec3 center_sphere1 = glm::vec3(meanx1, meany1, meanz1);
    glm::vec3 center_sphere2 = glm::vec3(meanx2, meany2, meanz2);

    float radius1 = max3(bbox1max.x - bbox1min.x, bbox1max.y - bbox1min.y, bbox1max.z - bbox1min.z);
    float radius2 = max3(bbox2max.x - bbox2min.x, bbox2max.y - bbox2min.y, bbox2max.z - bbox2min.z);

    bool condition1 = (center_sphere1.x - center_sphere2.x) <= (radius1 + radius2);
    bool condition2 = (center_sphere1.y - center_sphere2.y) <= (radius1 + radius2);
    bool condition3 = (center_sphere1.z - center_sphere2.z) <= (radius1 + radius2);

    if(condition1 && condition2 && condition3){
        return true;
    }
    else{
        return false;
    }
}

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

// bool spherical_collision(glm::vec3 pos1, glm::vec3 pos2, float r1, float r2){
//     if(norm(pos1 - pos2) <= (r1 + r2)){
//         return true;
//     }
//     else{
//         return false;
//     }
// }
