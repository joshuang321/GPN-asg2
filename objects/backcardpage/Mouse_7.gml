pressed = false;
audio_play_sound(buttonClick, 0, false);

layer_destroy_instances("Cards");

global.Game.temp_shop_offset -= 8;
if (0 == global.Game.temp_shop_offset)
	instance_deactivate_object(id);
else if (global.Game.temp_shop_offset + 8 <
	ds_list_size(global.Game.temp_shop_inventory))
	instance_activate_object(inst_63086B6D);

createWithOffset(global.Game.temp_shop_offset);