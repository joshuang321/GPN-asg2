audio_stop_all();
	
if (global.Game.level.gameState == _GAMESTATE_DEFEAT)
{
	instance_activate_layer("GameDefeat");
	layer_set_visible("GameDefeat", true);
	layer_background_sprite(layer_background_get_id("Background"),
		GameOver);
	audio_play_sound(gameDefeat, 0, false);
}
else if (global.Game.level.gameState == _GAMESTATE_VICTORY)
{
	instance_activate_layer("GameVictory");
	layer_set_visible("GameVictory", true);
	layer_background_sprite(layer_background_get_id("Background"),
		GameVictory);
	audio_play_sound(gameVictory, 0, false);
}

layer_destroy_instances("Instances");