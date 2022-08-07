function entityInit()
{
	Effects = ds_list_create();
	block = 0;
}

function entityDestroy()
{
	ds_list_destroy(Effects);
}

function enemyDestroy()
{
	entityDestroy();
	if (global.Game.level.gameState != _GAMESTATE_DEFEAT)
		audio_play_sound(enemyDeath, 0, false);
	ds_list_delete(global.Game.level.enemies, ds_list_find_index(global.Game.level.enemies, id));
	
	if (ds_list_empty(global.Game.level.enemies) &&
		global.Game.level.gameState != _GAMESTATE_DEFEAT)
		startNewGameState(_GAMESTATE_VICTORY);
}

function selectEnemy()
{
	if (_GAMESTATE_DISPLAY == global.Game.level.gameState)
	{
		audio_play_sound(enemySelect, 0, false);
		global.Game.level.enemySelected = id;
		time = 0;
	}
}

function dealDamage(_self, _damage)
{
	if (noone != _self)
	{
		with (_self)
		{
			var _exhaustedIndex = checkEffect("Exhausted");
			show_debug_message("index: " + string(_exhaustedIndex));
				
				
			if (-1 != _exhaustedIndex)
			{
				var _effect = Effects[| _exhaustedIndex];
				Effects[| _exhaustedIndex].data.turns --;
				if (0 == Effects[|_exhaustedIndex].data.turns)
					removeEffect(_exhaustedIndex);
				
				_damage *= (1 - _effect.data.amt);
				show_debug_message("Enemy Exhausted!");
			}
		}
	}
	with (id)
	{
		var _weakenedIndex = checkEffect("Weakened");
		
		if (-1 != _weakenedIndex)
		{
			var _effect = Effects[| _weakenedIndex];
			Effects[| _weakenedIndex].data.turns --;
			if (0 == Effects[|_weakenedIndex].data.turns)
				removeEffect(_weakenedIndex);
				
			_damage *= (1 + _effect.data.amt);
			show_debug_message("Enemy Weakened!");
		}
	}
	if (block < _damage)
	{
		if (block > 0)
			createFloatValue(_VALUETYPE_BLOCK, block);
		_damage -= block;
		block = 0;
	}
	else
	{
		createFloatValue(_VALUETYPE_BLOCK, _damage);
		block -= _damage;
		_damage = 0;
	}
	if (curhealth > _damage)
	{
		createFloatValue(_VALUETYPE_DAMAGE, _damage);
		curhealth -= _damage;
	}
	else
	{
		createFloatValue(_VALUETYPE_DAMAGE, curhealth);
		instance_destroy(id);
	}
}

function healHealth(_heal)
{
	var _prevhealth = curhealth;
	curhealth = min(curhealth + _heal, maxhealth);
	var _healTot = curhealth - _prevhealth;
	createFloatValue(_VALUETYPE_HEAL, _healTot);
}

#macro _VALUETYPE_DAMAGE	0
#macro _VALUETYPE_BLOCK		1
#macro _VALUETYPE_HEAL		2

function createFloatValue(_valueType, _value)
{
	var _floatFontInfo =  { value : _value };
	switch (_valueType)
	{
		case _VALUETYPE_DAMAGE:
			_floatFontInfo.font = global.damageFont;
			break;
			
		case _VALUETYPE_BLOCK:
			_floatFontInfo.font = global.blockFont;
			break;
			
		case _VALUETYPE_HEAL:
			_floatFontInfo.font = global.healFont;
			break;
	}
	instance_create_layer(x, y, "Values", floatingFont, _floatFontInfo);
}