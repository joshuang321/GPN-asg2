pressed = false;
if (variable_global_exists("Game") &&
	noone != global.Game)
{
	audio_play_sound(buttonClick, 0, false);
	room_goto(MapRoom);
}