//argument0 - actor performing range check
actor = argument0;

with(oActor) {
    tempActor = other.actor;

    //If this char's army doesn't match the army of the target char
    if(army != tempActor.army) {
        //check range
        if(point_distance(x + GRID_SIZE/2, y + GRID_SIZE/2, tempActor.x + GRID_SIZE/2, tempActor.y + GRID_SIZE/2) <= tempActor.attackRange) {
            if(!collision_line(x + GRID_SIZE/2, y + GRID_SIZE/2, tempActor.x + GRID_SIZE/2, tempActor.y + GRID_SIZE/2, oRock, false, false)) {
                map[gridX, gridY].attackNode = true;
                map[gridX, gridY].color = c_red;
            }
        }
    }
}


