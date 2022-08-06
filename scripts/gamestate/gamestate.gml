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
			audio_play_sound(cardDrawing, 0, false);
			with (global.Game.level.playerInst)
				block = 0;
				
			for (var _i=0;
				_i<ds_list_size(global.Game.level.enemies);
				_i++)
				with(global.Game.level.enemies[| _i])
					block = 0;
			
			global.Game.level.cardArray = chooseCards(4);
			var _x = 224;
			show_debug_message(global.Game.level.cardArray);
			for (var _i=0;
				_i<array_length(global.Game.level.cardArray);
				_i++)
			{
				global.Game.level.cardArray[_i].Animate = true;
				
				switch (global.Game.level.cardArray[_i].card_id)
				{
					case 1:
						instance_create_layer(_x, 864, "Instances", objAttackCard,
							global.Game.level.cardArray[_i]);
							break;
					
					case 2:
						instance_create_layer(_x, 864, "Instances", objBlockCard,
							global.Game.level.cardArray[_i]);
							break;
					
					default:
						instance_create_layer(_x, 864, "Instances", objMiscCard,
							global.Game.level.cardArray[_i]);
							break;
				}
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
			
			with (objAttackCard)
				instance_destroy(id);
			with (objBlockCard)
				instance_destroy(id);
			with (objMiscCard)
				instance_destroy(id);
			
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
			show_debug_message(ds_list_size(global.Game.level.enemies));
			with (inst_6F2A37EA)
				alarm[0] = ((ds_list_size(global.Game.level.enemies) -1) *
					global.GameConfig.enemy_animate_delay + 4) * _GAME_FPS;
			break;
				
		case _GAMESTATE_ENEMY_END:
			layer_set_visible("Menu", true);
			instance_activate_layer("Menu");
			global.Game.level.player_skillpts = global.Game.player_skillpts;
			startNewGameState(_GAMESTATE_DRAW);
			break;
			
		case _GAMESTATE_VICTORY:
			layer_set_visible("Menu", false);
			instance_deactivate_layer("Menu");
			destroyAllCards();
			with (global.Game.level.playerInst)
				alarm[0] = 3 * _GAME_FPS;
			break;
			
			
		case _GAMESTATE_DEFEAT:
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

function checkEffect(_id, _effect_id)
{
	var _hasEffect = false;
	with (_id)
	{
		for(var _i=0;
		_i<ds_list_size(Effects);
		_i++)
		{
			if (_effect_id == Effects[| _i])
				return true;
		}
	}
	return false;
}

function addEffect(_id, _effectName)
{
	checkEffect(_id, function(_id) {
		var _efx = _effectName;
		with(_id)
			ds_list_add(Effects, _efx);
	});
}

function destroyAllCards()
{
	with (objAttackCard)
				instance_destroy(id);
	with (objBlockCard)
		instance_destroy(id);
	with (objMiscCard)
		instance_destroy(id);
}