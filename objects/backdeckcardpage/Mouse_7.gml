pressed = false;
audio_play_sound(buttonClick, 0, false);

layer_destroy_instances("Cards");

global.Game.temp_deck_offset -= 4;
if (0 == global.Game.temp_deck_offset)
	instance_deactivate_object(id);
else if (global.Game.temp_deck_offset + 4 <
	ds_list_size(global.Game.player_card))
	instance_activate_object(inst_58EA9402);

layer_destroy_instances("DeckCards");
createDeckWithOffset(global.Game.temp_deck_offset);