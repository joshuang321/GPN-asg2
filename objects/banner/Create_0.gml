x = room_width/2 - sprite_width/2;
y = room_height/2 - sprite_height/2;

if (_GAME_STATE_VICTORY == global._room.game_state)
	sprite_index = victory;
else if (_GAME_STATE_DEFEAT == global._room.game_state)
	sprite_index = defeat;