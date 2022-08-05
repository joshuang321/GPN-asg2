pressed = false;

if (useCard())
{
	switch (card_id)
	{
		case _CARD_TYPE_HEAL:
			var _heal = (data.init_heal + (variable_instance_exists(id, "level")?
					level : 0) * data.inc_step);
			with (global.Game.level.playerInst)
			{
				audio_play_sound(playerHeal, 0, false);
				startAnimation(player_heal);
				healHealth(_heal);
			}
			instance_destroy(id);
			break;
	}
}