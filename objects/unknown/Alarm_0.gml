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
	for (var _i=0;
		_i<array_length(global.GameConfig.stages);
		_i++)
		if (global.GameConfig.stages[_i] <= global.Game.curLevel)
			global.Game.player_gold += global.GameConfig.stages[_i].gold;
			
	global.Game.curLevel++;
	
	instance_activate_layer("GameVictory");
	layer_set_visible("GameVictory", true);
	if (global.Game.curLevel == array_length(global.GameLevel))
		instance_destroy(inst_7EA4D2AC);
	layer_background_sprite(layer_background_get_id("Background"),
		GameVictory);
	audio_play_sound(gameVictory, 0, false);
}

layer_destroy_instances("Instances");