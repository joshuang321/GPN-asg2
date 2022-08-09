pressed = false;
audio_play_sound(buttonClick, 0, false);

layer_destroy_instances("Cards");

global.Game.temp_inventory_offset -= 4;
if (0 == global.Game.temp_inventory_offset)
	instance_deactivate_object(id);
else if (global.Game.temp_inventory_offset + 4 <
	ds_list_size(global.Game.player_card_inventory))
	instance_activate_object(inst_5FA6D287);

layer_destroy_instances("InventoryCards");
createInventoryWithOffset(global.Game.temp_inventory_offset);