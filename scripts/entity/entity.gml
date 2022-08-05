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
	ds_list_delete(global.Game.level.enemies, ds_list_find_index(
		global.Game.level.enemies, id));
	if (ds_list_empty(global.Game.level.enemies))
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

function dealDamage(_damage)
{
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