if (variable_global_exists("_room") &&
	_GAME_STATE_PLAYER  == global._room.game_state)
{
	global._room.enemy_selected = id;
}