var _nextlevelno = global._room.levelno+1;
destroy_room(global._room);
layer_destroy_instances("Instances");
global._room = new Room(_nextlevelno);