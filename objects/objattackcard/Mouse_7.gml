pressed = false;
if (variable_struct_exists(global.Game.level, "enemySelected") &&
	noone != global.Game.level.enemySelected &&
	useCard())
{
	var _dmg = data.init_dmg + (variable_instance_exists(id, "level") ?
		level : 0) * data.inc_step;
	with (global.Game.level.enemySelected)
	{
		audio_play_sound(playerSlash, 0, false);
		startAnimation(player_slash);
		dealDamage(_dmg);
	}
	global.Game.level.enemySelected = noone;
	instance_destroy(id);
}