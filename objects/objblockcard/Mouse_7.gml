pressed = false;
if (useCard())
{
	var _block = data.init_block + (variable_instance_exists(id, "level")?
			level : 0) * data.inc_step;
	with (global.Game.level.playerInst)
	{
		audio_play_sound(playerBlock, 0, false);
		startAnimation(armor);
		block += _block;
	}
	instance_destroy(id);
}