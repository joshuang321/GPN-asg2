pressed = false;

if (useCard())
{
	var _heal = data.init_heal + level * data.inc_step;
	with (global.Game.level.playerInst)
	{
		audio_play_sound(playerHeal, 0, false);
		startAnimation(player_heal);
		healHealth(_heal);
	}
	instance_destroy(id);
}