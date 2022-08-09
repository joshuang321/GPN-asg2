pressed = false;
if (noone != global.Game.level.enemySelected &&
	useCard())
{
	var _dmg = data.init_dmg + level * data.inc_step;
	with (global.Game.level.enemySelected)
	{
		audio_play_sound(playerSlash, 0, false);
		startAnimation(player_slash);
		dealDamage(noone, _dmg);
	}
	global.Game.level.enemySelected = noone;
}