//argument0 = the origin node (the node to start pathfinding from)
//argument1 = unit's movement range
//argument2 = unit's remaining actions

//rese all node data
wipe_nodes();

var open, closed;
var start, current, neighbor;
var tempG, range, costMod;

//declare variables from arguments
start = argument0;
range = argument1 * argument2;

//create data structures
open = ds_priority_create(); //priority list of walkable nodes
closed = ds_list_create(); //regular list of unwalkable nodes

//add starting node to the priority list
ds_priority_add(open, start, start.G);

//while open queue is NOT empty
while(ds_priority_size(open) > 0) {
    //remove node with lowest G score from "open" and assign it to "current"
    current = ds_priority_delete_min(open);
    //add that node to the "closed" list
    ds_list_add(closed, current);

    //loop through all current's neighbors
    for(ii = 0; ii < ds_list_size(current.neighbors); ii += 1) { //array.length
        //store current neighbor in neighbor variable
        neighbor = ds_list_find_value(current.neighbors, ii); //array[ii]
        
        //add neighbor to open list
        //IF: isn't already on the closed list, passable, no occupant, G score is less than movement range
        if(ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && neighbor.occupant == noone && neighbor.cost + current.G <= range) {
            //only calculate a new G if it hasn't already been calculated
            if(ds_priority_find_priority(open, neighbor) == 0 || ds_priority_find_priority(open, neighbor) == undefined) {
                costMod = 1;
                neighbor.parent = current;
                //diagonal neighbor
                if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY) {
                    costmod = 1.5;
                }

                //calculate G of neighbor with costMod in place
                neighbor.G = current.G + (neighbor.cost * costMod);

                //add neighbor to open list, with priority set to G
                ds_priority_add(open, neighbor, neighbor.G);
            //ELSE: neighbor's score has already been calculated for open list
            } else {
                //check if neighbor's score is lower if found from current node
                costMod = 1;
                //diagonal neighbor
                if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY) {
                    costmod = 1.5;
                }
                tempG = current.G + (neighbor.cost * costMod);
                //check if G would be lower 
                if(tempG < neighbor.G) {
                    neighbor.parent = current;
                    neighbor.G = tempG;
                    ds_priority_change_priority(open, neighbor, neighbor.G);
                }
            }
        }
    }
}

//round down all G scores for movement calculations
with(oNode) {
    G = floor(G);
}

//remove list from memory!!!
ds_priority_destroy(open);

//color all move nodes and destroy list
for(ii = 0; ii < ds_list_size(closed); ii += 1) { 
    current = ds_list_find_value(closed, ii);
    current.moveNode = true;

    color_move_node(current, argument1, argument2);
}

start.moveNode = false;
start.color = c_white;

//destroy closed list
ds_list_destroy(closed);
