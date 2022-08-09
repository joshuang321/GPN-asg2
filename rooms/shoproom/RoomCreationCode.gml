audio_stop_all();

audio_play_sound(shopBGM, 0, true);
createWithOffset(0);

if (ds_list_size(global.Game.temp_shop_inventory) < 8)
	instance_deactivate_object(inst_63086B6D);

instance_deactivate_layer(inst_334114D2);

instance_deactivate_layer("PauseMenu");
layer_set_visible("Pause", false);