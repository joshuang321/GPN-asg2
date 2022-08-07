pressed = false;

if (noone != global.Game.level.enemySelected &&
	useCard())
{
	var _dmg = 0;
	var _data = data;
	with (global.Game.level.playerInst)
		var _health = maxhealth * _data.health_percent_offset - curhealth;
	
	_dmg =  max(0, _health) * (data.init_percent_dmg +
		level * data.inc_step)
	
	with (global.Game.level.enemySelected)
	{
		audio_play_sound(playerDesperateAttack, 0, false);
		startAnimation(player_desperateattack);   
		dealDamage(noone, _dmg);
	}
	instance_destroy(id);
}