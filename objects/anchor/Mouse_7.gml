pressed = false;
if (sAnchor == sprite_index)
{	
	audio_play_sound(buttonClick, 0, false);
	room_goto(LevelRoom);
}