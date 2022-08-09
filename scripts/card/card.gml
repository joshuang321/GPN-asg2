#macro _CARD_YEND	500
#macro _CARD_SP		0.02

function cardInit()
{
	pressed = false;
	time = 0;
	channel = animcurve_get_channel(cardAnimation, 0);
}

function instantiateCard(_x, _Card)
{
	instance_create_layer(_x, 864, "Cards", asset_get_index(_Card.obj),
		_Card);
}

function instantiateCardItem(_x, _y, _Card)
{
	show_debug_message(_Card.obj);
	return instance_create_layer(_x, _y, "Cards", asset_get_index(_Card.obj + "Item"),
		_Card);
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
	var _card_cost = card_cost.init + level * card_cost.inc_step;
	var _useCard = (global.Game.level.player_skillpts < _card_cost)? false : true;
	if (_useCard)
		global.Game.level.player_skillpts -= _card_cost;
	else
		audio_play_sound(noEnergy, 0, false);
	return _useCard;
}

function levelUpCard()
{
	if (global.Game.player_gold >= upgrade_cost.init + level *
		upgrade_cost.inc_step)
	{
		global.Game.player_gold -= upgrade_cost.init + level *
			upgrade_cost.inc_step;
		level ++;
		audio_play_sound(upgradeCard, 0, false);
		global.Game.player_card[| card_index].level++;
	}
	else
		audio_play_sound(notEnoughGold, 0, false);
}

function createWithOffset(_offset)
{
	var _y = 96;
	var _x = 0;

	for (var _j=0;
	_j<2;
	_j++)
	{
		_x = 416;
		for (var _i=0;
			_i<4;
			_i++)
		{
			show_debug_message(_offset + _i + 4 *_j);
			if ((_offset + _i + 4 *_j) == ds_list_size(global.Game.temp_shop_inventory))
				return;
			
			var _card_obj_index = instantiateCardItem(_x, _y,
				global.Game.temp_shop_inventory[| (_offset + _i + 4 * _j)]);
			with (_card_obj_index)
				card_index = _offset + _i + 4 * _j;
			_x += 195;
		}
		_y += 294;
	}
}