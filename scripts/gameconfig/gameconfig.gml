#macro _GAME_FPS 50

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

function loadGame()
{
	global.uiFont = font_add("DampfPlatzsh.ttf", 72,
		false, false, 32, 128);
	draw_set_font(global.uiFont);
	global.uiSmallFont = font_add("DampfPlatzsh.ttf", 24,
		false, false, 32, 128);
	global.uiVerySmallFont = font_add("DampfPlatzsh.ttf", 14,
		false, false, 32, 128);
		
	global.blockFont = font_add_sprite(blockFont, ord("0"), true, 2);
	global.damageFont = font_add_sprite(damageFont, ord("0"), true, 2);
	global.healFont = font_add_sprite(healFont, ord("0"), true, 2);
	
	global.GameConfig = load_json_data("GameConfig.json",
		"Failed to load Game Config!",
		"GameConfig.json does not exists!");

	
	global.GameLevel = load_json_data("GameLevel.json",
		"Failed to load Levels!",
		"GameLevel.json does not exists!");
	
	global.Game = noone;
		
	game_set_speed(_GAME_FPS, gamespeed_fps);
		
}

function GameEnemy(_enemyData, _enemyHealth) constructor
{
	data = _enemyData;
	maxhealth = _enemyHealth;
	curhealth = _enemyHealth;
}

function GameCard(_Card) constructor
{
	card_id = _Card.card_id;
	obj = _Card.obj;
	sprite = _Card.sprite;
	data = _Card.data;
	card_cost = _Card.card_cost;
	upgrade_cost = _Card.upgrade_cost;
	level = 0;
}

function GamePlayer(_playerHealth) constructor
{
	maxhealth = _playerHealth;
	curhealth = _playerHealth;
}

#macro Y_STANDING	500

function Level() constructor
{
	player_skillpts = global.Game.player_skillpts;
	player_stack = ds_stack_create();
	
	show_debug_message(ds_list_size(global.Game.player_card));
	randomize();
	ds_list_shuffle(global.Game.player_card);
	
	playerInst = instance_create_layer(118, Y_STANDING, "Instances", ePlayer,
		new GamePlayer(global.Game.player_health));
	
	for (var _i=0;
		_i<ds_list_size(global.Game.player_card);
		_i++)
		ds_stack_push(player_stack, global.Game.player_card[|_i]);
	
	
	player_pending_list = ds_list_create();
	enemies = ds_list_create();
	enemySelected = noone;
	enemyTurn = noone;
}

function cGame() constructor
{
	player_health = global.GameConfig.starting_player.init_health;
	player_skillpts = global.GameConfig.starting_player.init_skillpt;
	player_card = ds_list_create();
	player_card_inventory = ds_list_create();
	temp_shop_inventory = ds_list_create();
	
	for (var _i=0;
		_i<min(global.GameConfig.max_card_slot,
			array_length(global.GameConfig.starting_player.init_card));
		_i++)
	{
		var _card = findCardFromId(global.GameConfig.starting_player.init_card[_i]);
		_card = new GameCard(_card);
		ds_list_add(player_card, _card);
		ds_list_add(temp_shop_inventory, _card);
	}
	
	if (global.GameConfig.max_card_slot <
		array_length(global.GameConfig.starting_player.init_card))
	{
		for (var _j=_i;
			_j<array_length(global.GameConfig.starting_player.init_card);
			_j++)
		{
			_card = findCardFromId(global.GameConfig.starting_player.init_card[_j]);
			_card = new GameCard(_card);
			
			ds_list_add(player_card_inventory, _card);
			ds_list_add(temp_shop_inventory, _card);
		}
	}
	temp_shop_offset = 0;
	temp_deck_offset = 0;
	temp_inventory_offset = 0;
	
	player_gold = 0;
	curLevel = 19;
}

function NewLevel(_levelNo)
{
	if (2 == global.Game.curLevel mod 5)
	{
		room_goto(ShopRoom);
		return;
	}
	else if (global.Game.curLevel == array_length(global.GameLevel))
	{
		room_goto(StoryRoom);
		return;
	}
	
	global.Game.level = new Level();
	var _level = getLevel(_levelNo);
	
	var _x = room_width - 98;
	var _y = Y_STANDING;		
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
				new GameEnemy(_enemy.data, _level.enemies[_i].health)));
		_x -= 50;
	}
	startNewGameState(_GAMESTATE_DRAW);
}

function loadNewGame()
{
	global.Game = new cGame();
}

function loadStory()
{
	global.Game.storyIndex = 0;
	audio_play_sound(asset_get_index(global.Game.curLevel == array_length(global.GameLevel)
		? global.GameConfig.final_cutscene.bgm : global.GameConfig.beginning_cutscene.bgm),
		0, true);
}

function loadNextParagraph()
{
	var _curParagraph = global.Game.curLevel == array_length(global.GameLevel) ? global.GameConfig.final_cutscene.paragraphs :
	global.GameConfig.beginning_cutscene.paragraphs;
	
	if (global.Game.storyIndex == array_length(_curParagraph))
	{
		room_goto(MapRoom);
		return;
	}
	
	layer_background_sprite(layer_background_get_id("Background"), asset_get_index(
		_curParagraph[global.Game.storyIndex].background));

	global.Game.storyIndex++;
}

function loadCutscene()
{
	layer_background_sprite(layer_background_get_id("Background"), asset_get_index(
		 global.GameConfig.story[floor(global.Game.curLevel/5)].background));
}

function getLevel(_levelNo)
{
	return (array_length(global.GameLevel) < (_levelNo + 1))? noone :
		global.GameLevel[_levelNo];
}

function setBackground(_level)
{
	if (2 != global.Game.curLevel mod 5 &&
		global.Game.curLevel != array_length(global.GameLevel))
	{
		for (var _i=0;
		_i<array_length(global.GameConfig.background);
		_i++)
		{
			if (_level.background_id = global.GameConfig.background[_i].id)
			{
				layer_background_sprite(layer_background_get_id("Background"),
					asset_get_index(global.GameConfig.background[_i].sprite));
				audio_play_sound(asset_get_index(global.GameConfig.background[_i].bgm), 0, true);
			}
		}
	}
}
	

function destroyCurrentGame()
{
	ds_list_destroy(global.Game.player_card);
	ds_list_destroy(global.Game.player_card_inventory);
	ds_list_destroy(global.Game.temp_shop_inventory);
	delete global.Game;
}

function destroyCurrentLevel()
{
	ds_list_destroy(global.Game.level.player_pending_list);
	ds_list_destroy(global.Game.level.enemies);
	delete global.Game.level;
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

function findCardType(_card_type)
{
	for (var _i=0;
		_i<array_length(global.GameConfig.card_types);
		_i++)
		if (_card_type == global.GameConfig.card_types[_i].card_type)
			return global.GameConfig.card_types[_i];
	return noone;
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