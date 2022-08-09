pressed = false;
audio_play_sound(buttonClick, 0, false);

layer_destroy_instances("Cards");

global.Game.temp_shop_offset += 8;

if (global.Game.temp_shop_offset +8 >
	ds_list_size(global.Game.temp_shop_inventory))
	instance_deactivate_object(id);
else if (global.Game.temp_shop_offset - 8 >=
	0)
	instance_activate_object(inst_334114D2);
	

createWithOffset(global.Game.temp_shop_offset);