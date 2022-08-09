pressed = false;
audio_play_sound(buttonClick, 0, false);
if (global.GameConfig.max_card_slot == ds_list_size(global.Game.player_card))
	room_goto(MapRoom);