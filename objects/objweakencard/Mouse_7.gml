 pressed = false;

if (noone != global.Game.level.enemySelected &&
	useCard())
{
	var _weaken_percent = min(1, data.init_percent_weaken + 
		level * data.inc_step);
	var _turns = data.turns;
	with (global.Game.level.enemySelected)
	{
		audio_play_sound(playerWeakening, 0, false);
		var _effect = { amt : _weaken_percent, turns : _turns };
		addEffect("Weakened", _effect);
	}
}