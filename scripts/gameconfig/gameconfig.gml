#macro _GAME_FPS 60

function loadGame()
{
	global.uiFont = font_add("EvilEmpire-4BBVK.ttf", 72,
		false, false, 32, 128);
	draw_set_font(global.uiFont);
	global.uiSmallFont = font_add("EvilEmpire-4BBVK.ttf", 24,
		false, false, 32, 128);
	global.uiVerySmallFont = font_add("EvilEmpire-4BBVK.ttf", 14,
		false, false, 32, 128);
	
	global.GameConfig = load_json_data("GameConfig.json",
		"Failed to load Game Config!",
		"GameConfig.json does not exists!");
	show_debug_message(global.GameConfig);
	
	global.GameLevel = load_json_data("GameLevel.json",
		"Failed to load Levels!",
		"GameLevel.json does not exists!");
	show_debug_message(global.GameLevel);
		
	game_set_speed(_GAME_FPS, gamespeed_fps);
		
}

function Level() constructor
{
	player_skillpts = global.Game.player_skillpts;
	player_stack = ds_stack_create();
	
	show_debug_message(ds_list_size(global.Game.player_card));
	randomize();
	ds_list_shuffle(global.Game.player_card);
	
	playerInst = instance_create_layer(118, room_height -592,
		"Instances",
		ePlayer,
		{
			maxhealth : global.Game.player_health,
			curhealth : global.Game.player_health
		});
	
	for (var _i=0;
		_i<ds_list_size(global.Game.player_card);
		_i++)
	{
		ds_stack_push(player_stack, global.Game.player_card[|_i]);
	}
	
	
	player_pending_list = ds_list_create();
	enemies = ds_list_create();
}

function Game() constructor
{
	player_health = global.GameConfig.starting_player.init_health;
	player_skillpts = global.GameConfig.starting_player.init_skillpt;
	player_card = ds_list_create();
	
	for (var _i=0;
		_i<array_length(global.GameConfig.starting_player.init_card);
		_i++)
		ds_list_add(player_card, findCardFromId(global.GameConfig.starting_player.init_card[_i]));
	
	player_gold = 0;
	curLevel = 0;
}

function NewLevel(_levelNo)
{
	global.Game.level = new Level();
	
	var _level = getLevel(_levelNo);
	
	var _x = room_width - 98;
	var _y = room_height - 592;		
	for (var _i =0;
			_i<array_length(_level.enemies);
			_i++)
	{
		var _enemy = findEnemyFromId(_level.enemies[_i].id);
		show_debug_message(_enemy);
		var _spriteInfo = sprite_get_info(asset_get_index(_enemy.sprite));
		
		_x -= _spriteInfo.width;
		ds_list_add(global.Game.level.enemies,
			instance_create_layer(_x, _y, "Instances", asset_get_index(_enemy.obj),
			{ 
				data : _enemy.data,
				maxhealth : _level.enemies[_i].health,
				curhealth : _level.enemies[_i].health
			}));
		_x -= 16;
	}
	startNewGameState(_GAMESTATE_DRAW);
}

function getLevel(_levelNo)
{
	return (array_length(global.GameLevel) < (_levelNo + 1))? noone :
		global.GameLevel[_levelNo];
}

function destroyCurrentGame()
{
	ds_list_destroy(global.Game.player_card);
	delete global.Game;
}

function destroyCurrentLevel()
{
	ds_stack_destroy(global.Game.Level.player_card);
	ds_list_destroy(global.Game.Level.player_pending_list);
	ds_list_destroy(global.Game.Level.enemies);
	delete global.Game.Level;
}

function findCardFromId(_card_id)
{
	for (var _i=1;
		_i<array_length(global.GameConfig.card);
		_i++)
		if (_card_id == global.GameConfig.card[_i].card_id)
			return global.GameConfig.card[_i];
	return global.GameConfig.card[0];
}

function findEnemyFromId(_enemy_id)
{
	for (var _i=0;
		_i<array_length(global.GameConfig.enemy);
		_i++)
		if (_enemy_id ==global.GameConfig.enemy[_i].id)
			return global.GameConfig.enemy[_i];
	return noone;
} 

function loadSaved(_saveFilename)
{

}

function loadNew()
{
	global.Game = new Game();
}

function load_json_data(_filename, _load_fails_dmessage,
	_file_dnexists_dmessage, _global_var_str)
{
	if (file_exists(_filename))
	{
		var _buffer = buffer_load(_filename);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		var _data = json_parse(_string);
		if (-1 == _data)
			show_debug_message(_load_fails_dmessage);
		else
			return _data;
	}
	else {
		show_debug_message(_file_dnexists_dmessage);
	}
	return noone;
}

function addCardToPending(_id)
{
}