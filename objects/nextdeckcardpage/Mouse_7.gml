pressed = false;
audio_play_sound(buttonClick, 0, false);

layer_destroy_instances("Cards");

global.Game.temp_deck_offset += 4;

if (global.Game.temp_deck_offset +4 >=
	ds_list_size(global.Game.player_card))
	instance_deactivate_object(id);
else if (global.Game.temp_deck_offset - 4 >=0)
	instance_activate_object(inst_41BBA979);

layer_destroy_instances("DeckCards");
createDeckWithOffset(global.Game.temp_deck_offset);