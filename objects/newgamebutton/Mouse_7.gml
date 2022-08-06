pressed = false;
audio_play_sound(buttonClick, 0, false);
if (variable_global_exists("Game") &&
	noone != global.Game)
	destroyCurrentGame();
loadNew();
room_goto(MapRoom);