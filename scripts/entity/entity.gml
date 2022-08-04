function entityInit()
{
	Effects = ds_list_create();
	block = 0;
}

function entityDestroy()
{
	ds_list_destroy(entityDestroy);
}

function selectEnemy()
{
	global.Game.level.enemySelected = id;
}

function dealDamage(_damage)
{
	if (block < _damage)
	{
		_damage -= block;
		block = 0;
	}
	else
	{
		block -= _damage;
		_damage = 0;
	}
	if (curhealth > _damage)
		curhealth -= _damage;
	else
		instance_destroy(id);
}