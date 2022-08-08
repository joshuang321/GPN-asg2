#macro _GAMESTATE_DRAW			0
#macro _GAMESTATE_DISPLAY		1
#macro _GAMESTATE_PLAYER_END	2
#macro _GAMESTATE_ENEMY			3
#macro _GAMESTATE_ENEMY_END		4

#macro _GAMESTATE_DEFEAT		5
#macro _GAMESTATE_VICTORY		6

function startNewGameState(_gameState)
{

	global.Game.level.gameState = _gameState;
		
	switch (_gameState)
	{
		case _GAMESTATE_DRAW:
			for (var _i=0;
				_i<ds_list_size(global.Game.level.enemies);
				_i++)
				with(global.Game.level.enemies[| _i])
					block = 0;
			with (global.Game.level.playerInst)
				block = 0;
			
			audio_play_sound(cardDrawing, 1, false);
			global.Game.level.cardArray = chooseCards(4);
			
			var _x = 224;
			for (var _i=0;
				_i<array_length(global.Game.level.cardArray);
				_i++)
			{
				instantiateCard(_x, global.Game.level.cardArray[_i]);
				_x+=195;
			}
			startNewGameState(_GAMESTATE_DISPLAY);
			break;
			
		case _GAMESTATE_DISPLAY:
			break;
				
		case _GAMESTATE_PLAYER_END:
			layer_set_visible("Menu", false);
			instance_deactivate_object(inst_14642C0E);
			instance_deactivate_object(inst_68DD3F95);
			instance_deactivate_object(inst_36C961E6);
			
			global.Game.level.enemySelected  = noone;
			layer_destroy_instances("Cards");
			
			for (var _i=0;
				_i<array_length(global.Game.level.cardArray);
				_i++)
				ds_list_add(global.Game.level.player_pending_list,
					global.Game.level.cardArray[_i]);
			
			startNewGameState(_GAMESTATE_ENEMY);
			break;
				
		case _GAMESTATE_ENEMY:
			for (var _i=0;
				_i<ds_list_size(global.Game.level.enemies);
				_i++)
				with (global.Game.level.enemies[|_i])
					alarm[0] = (_i * global.GameConfig.enemy_animate_delay + 2) * _GAME_FPS;
			
			with (inst_1FB0A37B)
				alarm[1] = ((ds_list_size(global.Game.level.enemies) -1) *
					global.GameConfig.enemy_animate_delay + 4) * _GAME_FPS;
			break;
				
		case _GAMESTATE_ENEMY_END:
			for (var _i=0;
				_i<ds_list_size(global.Game.level.enemies);
				_i++)
				with (global.Game.level.enemies[|_i])
					doEffectTurn();
			
			with (global.Game.level.playerInst)
				doEffectTurn();
			
			layer_set_visible("Menu", true);
			instance_activate_layer("Menu");
			global.Game.level.player_skillpts = global.Game.player_skillpts;
			startNewGameState(_GAMESTATE_DRAW);
			break;
		
		
		case _GAMESTATE_VICTORY:
		case _GAMESTATE_DEFEAT:
			layer_set_visible("Menu", false);
			instance_deactivate_layer("Menu");
			layer_destroy_instances("Cards");
			show_debug_message("FINALGAMESTATE:" + string(global.Game.level.gameState));
			
			with (inst_1FB0A37B)
				alarm[0] = 4 * _GAME_FPS;
			break;
			
		default:
			show_debug_message("INVALID GAMESTATE DETECTED");
			break;
	}
}

function chooseCards(_amount)
{
	var _cardArray = array_create(_amount);
	if (ds_stack_empty(global.Game.level.player_stack))
	{
		show_debug_message("cards is empty! reshuffling cards..");
		ds_list_shuffle(global.Game.level.player_pending_list);
		for (var _i=0;
			_i<ds_list_size(global.Game.level.player_pending_list);
			_i++)
			ds_stack_push(global.Game.level.player_stack, global.Game.level.player_pending_list[| _i]);
			
		ds_list_clear(global.Game.level.player_pending_list);
	}
	for (var _i=0;
		_i<_amount && !ds_stack_empty(global.Game.level.player_stack);
		_i++)
		_cardArray[_i] = ds_stack_pop(global.Game.level.player_stack);
	return _cardArray;	
}

function instantiateCard(_x, _Card)
{
	instance_create_layer(_x, 864, "Cards", asset_get_index(_Card.obj),
		_Card);
}

function doEffectTurn()
{
	var _exhaustedIndex = checkEffect("Exhausted");
	if (-1 != _exhaustedIndex)
	{
		var _effect = Effects[| _exhaustedIndex];
		Effects[| _exhaustedIndex].data.turns --;
		if (0 == Effects[|_exhaustedIndex].data.turns)
			removeEffect(_exhaustedIndex);
	}
				
	var _weakenedIndex = checkEffect("Weakened");
	if (-1 != _weakenedIndex)
	{
		var _effect = Effects[| _weakenedIndex];
		Effects[| _weakenedIndex].data.turns --;
		if (0 == Effects[|_weakenedIndex].data.turns)
			removeEffect(_weakenedIndex);
	}
}

function getEffectId(_effect)
{
	for (var _i=0;
		_i<array_length(global.GameConfig.effect);
		_i++)
		if (_effect == global.GameConfig.effect[_i].name)
			return global.GameConfig.effect[_i].id;
			
	return -1;
}

function getEffectSprite(_effectId)
{
	for (var _i=0;
		_i<array_length(global.GameConfig.effect);
		_i++)
		if (_effectId == global.GameConfig.effect[_i].id)
			return global.GameConfig.effect[_i].sprite;
	return noone;
}

function getEffectNameFromId(_effectId)
{
	for (var _i=0;
		_i<array_length(global.GameConfig.effect);
		_i++)
		if (_effectId == global.GameConfig.effect[_i].id)
			return global.GameConfig.effect[_i].name;
	return noone;
}

function checkEffect(_effect)
{
	var _effectId = getEffectId(_effect);
	show_debug_message(_effectId);
	for (var _i=0;
		_i<ds_list_size(Effects);
		_i++)
		if (_effectId == Effects[| _i].effect_id)
			return _i;
			
	return -1;
}

function addEffect(_effect, _data)
{
	var _effectId = getEffectId(_effect);
	show_debug_message(_effectId);
	if (-1 == checkEffect(_effect))
	{
		ds_list_add(Effects, { effect_id :_effectId, data : _data });
		show_debug_message("sprite_index: " + string(asset_get_index(getEffectSprite(_effectId))));
		startAnimation(asset_get_index(getEffectSprite(_effectId)));
		instance_create_layer(x, y, "Values", floatingEffect, { effect : _effect + "!",
			color : #FFFF44 });
	}
	else
	show_debug_message("effect not found");
}

function removeEffect(_effectIndex)
{
	instance_create_layer(x, y, "Values", floatingEffect, { effect :
		getEffectNameFromId(Effects[| _effectIndex].effect_id) +
		" fades", color : #DDDDDD });
	ds_list_delete(Effects, _effectIndex);
}

function handleStoryButton()
{
	if (sAnchor == sprite_index)
	{	
		if (0 == global.Game.curLevel mod 5)
			room_goto(StoryRoom);
		else
		{	
			audio_play_sound(buttonClick, 0, false);
			room_goto(LevelRoom);
		}
	}
}