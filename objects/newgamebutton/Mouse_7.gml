pressed = false;
audio_play_sound(buttonClick, 0, false);
if (noone != global.Game)
	destroyCurrentGame();
loadNewGame();
room_goto(MapRoom);