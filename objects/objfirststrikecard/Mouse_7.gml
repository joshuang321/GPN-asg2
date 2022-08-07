pressed = false;

if (noone != global.Game.level.enemySelected &&
	useCard())
{
	var _dmg = 0;
	var _enemy_health = 0;
	with (global.Game.level.enemySelected)
		_enemy_health = (maxhealth - curhealth)/ maxhealth;
	_dmg =  _enemy_health * (data.init_dmg +
		level * data.inc_step);
	
	with (global.Game.level.enemySelected)
	{
		audio_play_sound(playerFirstStrike, 0, false);
		startAnimation(player_firststrike);
		dealDamage(noone, _dmg);
	}
	instance_destroy(id);
}