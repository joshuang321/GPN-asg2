pressed = false;
if (useCard())
{
	var _block = data.init_block + level * data.inc_step;
	with (global.Game.level.playerInst)
	{
		audio_play_sound(playerBlock, 0, false);
		startAnimation(armor);
		block += _block;
	}
}