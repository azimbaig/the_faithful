//argument0 - node ID to oclor
//argument1 - selectedActor's move value
//argument1 - selectedActor's actions value

var node, move, actions;

node = argument0;
move = argument1;
actions = argument2;

if(actions > 1) {
    //If distance to node is more than available moves
    if(node.G > move) {
        node.color = c_yellow;
    } else {
        node.color = c_aqua;
    }
} else {
    node.color = c_yellow;    
}

