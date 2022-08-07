pressed = false;

if (noone != global.Game.level.enemySelected &&
	useCard())
{
	var _exhaust_percent = min(1, data.init_percent_exhaust + 
		level * data.inc_step);
	var _turns = data.turns;
	with (global.Game.level.enemySelected)
	{
		addEffect("Exhausted", { amt : _exhaust_percent,
			turns : _turns });
		for (var _i=0;
			_i<ds_list_size(Effects);
			_i++)
			show_debug_message(Effects[| _i]);
			
	}
	instance_destroy(id);
}