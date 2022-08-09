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
	var _amt  = 0;
	for (var _i=0;
		_i<array_length(global.GameConfig.stages);
		_i++)
		if (global.GameConfig.stages[_i].start_at > global.Game.curLevel)
		{
			_amt = global.GameConfig.stages[_i-1].gold * array_length(global.GameLevel[
				global.Game.curLevel].enemies);
			break;
		}
	
	global.Game.curLevel++;
	global.Game.player_gold += _amt;
	
	instance_activate_layer("GameVictory");
	layer_set_visible("GameVictory", true);
	instance_create_layer(0, 400, "GameVictory", GoldText, { amt : _amt });
	
	if (global.Game.curLevel == array_length(global.GameLevel))
	{
		instance_destroy(inst_18143139);
		with (inst_7EA4D2AC)
			menu_string = "Final Cutscene";
	}
	
	if (0 == global.Game.curLevel mod 5)
		instance_deactivate_object(inst_7EA4D2AC);
	
	layer_background_sprite(layer_background_get_id("Background"),
		GameVictory);
	audio_play_sound(gameVictory, 0, false);
}

layer_destroy_instances("Instances");