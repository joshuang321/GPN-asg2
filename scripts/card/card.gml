#macro _CARD_YEND	500
#macro _CARD_SP		0.02

function cardInit()
{
	pressed = false;
	time = 0;
	channel = animcurve_get_channel(cardAnimation, 0);
}

function nextStep()
{
	
	if (time <= 1)
	{
		time += _CARD_SP;
		y = ystart + animcurve_channel_evaluate(channel, time) *
			(_CARD_YEND - ystart);
	}
}

function useCard()
{
	var _card_cost = card_cost.init + (variable_instance_exists(id, "level") ?
		level : 0) * card_cost.inc_step;
	var _useCard = (global.Game.level.player_skillpts < _card_cost)? false : true;
	if (_useCard)
		global.Game.level.player_skillpts -= _card_cost;
	show_debug_message(_useCard);
	return _useCard;
}