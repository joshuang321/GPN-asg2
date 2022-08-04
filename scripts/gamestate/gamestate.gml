#macro _GAMESTATE_DRAW			0
#macro _GAMESTATE_DISPLAY		1
#macro _GAMESTATE_PLAYER_END	2
#macro _GAMESTATE_ENEMY			3
#macro _GAMESTATE_ENEMY_END		4

function startNewGameState(_gameState)
{

	global.Game.level.gameState = _gameState;
		
	switch (_gameState)
	{
		case _GAMESTATE_DRAW:
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
			with (inst_2CBE477C)
				alarm[0] = ((ds_list_size(global.Game.level.enemies) -1) *
					global.GameConfig.enemy_animate_delay + 4) * _GAME_FPS;
			break;
				
		case _GAMESTATE_ENEMY_END:
			global.Game.level.player_skillpts = global.Game.player_skillpts;
			startNewGameState(_GAMESTATE_DRAW);
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
			if (_effectid == Effects[| _i])
				return true;
		}
	}
	return true;
}

function addEffect(_id, _effectName)
{
	checkEffect(_id, function(_id) {
		var _efx = _effectName;
		with(_id)
			ds_list_add(Effects, _efx);
	});
}