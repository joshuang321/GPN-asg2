pressed = false;
if (variable_struct_exists(global.Game.level, "enemySelected") &&
	noone != global.Game.level.enemySelected &&
	useCard())
{
	var _dmg = data.init_dmg + (variable_instance_exists(id, "level") ?
		level : 0) * data.inc_step;
	with (global.Game.level.enemySelected)
	{
		startAnimation(player_slash);
		dealDamage(_dmg);
	}
	audio_play_sound(playerSlash, 0, false);
	instance_destroy(id);
}