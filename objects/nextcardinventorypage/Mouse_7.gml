pressed = false;
audio_play_sound(buttonClick, 0, false);

layer_destroy_instances("Cards");

global.Game.temp_inventory_offset += 4;

if (global.Game.temp_inventory_offset +4 >=
	ds_list_size(global.Game.player_card_inventory))
	instance_deactivate_object(id);
else if (global.Game.temp_inventory_offset - 4 >=
	0)
	instance_activate_object(inst_34134C65);
	

layer_destroy_instances("InventoryCards");
createInventoryWithOffset(global.Game.temp_inventory_offset);