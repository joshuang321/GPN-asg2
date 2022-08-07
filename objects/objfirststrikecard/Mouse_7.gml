pressed = false;

if (noone != global.Game.level.enemySelected &&
	useCard())
{
	var _dmg = 0;
	var _enemy_health = 0;
	var _health_percent_offset = data.health_percent_offset;
	with (global.Game.level.enemySelected)
		_enemy_health = curhealth - (maxhealth * _health_percent_offset);
	_dmg =  max(0, _enemy_health) * (data.init_percent_dmg +
		level * data.inc_step)
	
	with (global.Game.level.enemySelected)
	{
		audio_play_sound(playerFirstStrike, 0, false);
		startAnimation(player_firststrike);
		dealDamage(noone, _dmg);
	}
	instance_destroy(id);
}