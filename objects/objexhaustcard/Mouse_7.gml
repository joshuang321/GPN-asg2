pressed = false;

if (noone != global.Game.level.enemySelected &&
	useCard())
{
	var _exhaust_percent = min(1, data.init_percent_exhaust + 
		level * data.inc_step);
	var _turns = data.turns;
	with (global.Game.level.enemySelected)
	{
		audio_play_sound(playerExhaust, 0, false);
		addEffect("Exhausted", { amt : _exhaust_percent,
			turns : _turns });
			
	}
	instance_destroy(id);
}