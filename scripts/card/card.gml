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

function instantiateDeckCardItem(_x, _y, _Card)
{
	show_debug_message(_Card.obj);
	return instance_create_layer(_x, _y, "DeckCards", asset_get_index(_Card.obj + "DeckBuilderItem"),
		_Card);
}

function instantiateInventoryCardItem(_x, _y, _Card)
{
	show_debug_message(_Card.obj);
	return instance_create_layer(_x, _y, "InventoryCards", asset_get_index(_Card.obj + "DeckBuilderItem"),
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

function calculateNormalCost()
{
	return  card_cost.init + level * card_cost.inc_step;
}

function calculateCost()
{
	var _card_cost = calculateNormalCost();
	with (global.Game.level.playerInst)
	{
		var _effectIndex = checkEffect("Hypnotized");
		if (-1 != _effectIndex)
		{
			var _effect = Effects[| _effectIndex];
			_card_cost += _effect.data.extra_cost;
		}
	}
	return _card_cost;
}

function useCard()
{
	var _card_cost = calculateCost();
	show_debug_message(_card_cost);
	var _useCard = (global.Game.level.player_skillpts < _card_cost)? false : true;
	if (_useCard)
	{
		global.Game.level.player_skillpts -= _card_cost;
		instance_destroy(id);
	}
	else
		audio_play_sound(noEnergy, 0, false);
		
	with (global.Game.level.playerInst)
	{
		var _effectIndex = checkEffect("Darkened");
		if (-1 != _effectIndex)
		{
			var _effect = Effects[| _effectIndex];
			var _prevuseCard = _useCard;
			
			_useCard = _useCard ? (_effect.data.miss_probability>random(1.0)?
				false : true) : false;
			if (_prevuseCard && !_useCard)
				with(global.Game.level.playerInst)
					showEffect("Miss");
		}
	}
	
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
		global.Game.temp_shop_inventory[| card_index].level++;
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

function createDeckWithOffset(_offset)
{
	var _y = 160;
	var _x = 416;
	
	for (var _i=0;
		_i<4;
		_i++)
	{
		show_debug_message(_offset + _i);
		if ((_offset + _i) == ds_list_size(global.Game.player_card))
			return;
			
		var _card_obj_index = instantiateDeckCardItem(_x, _y,
			global.Game.player_card[| (_offset + _i)]);
		with (_card_obj_index)
			card_index = _offset + _i;
		_x += 195;
	}
}

function createInventoryWithOffset(_offset)
{
	var _y = 448;
	var _x = 416;
	
	for (var _i=0;
		_i<4;
		_i++)
	{
		show_debug_message(_offset + _i);
		if ((_offset + _i) == ds_list_size(global.Game.player_card_inventory))
			return;
			
		var _card_obj_index = instantiateInventoryCardItem(_x, _y,
			global.Game.player_card_inventory[| (_offset + _i)]);
		with (_card_obj_index)
			card_index = _offset + _i;
		_x += 195;
	}
}

function handleCardTransfer()
{
	if (layer_get_id("DeckCards") == layer)
	{
		var _Card = global.Game.player_card[| card_index];
		ds_list_delete(global.Game.player_card, card_index);
		ds_list_add(global.Game.player_card_inventory, _Card);
	}
	else if (global.GameConfig.max_card_slot > ds_list_size(global.Game.player_card))
	{
		_Card = global.Game.player_card_inventory[| card_index];
		ds_list_delete(global.Game.player_card_inventory, card_index);
		ds_list_add(global.Game.player_card, _Card);
	}
	layer_destroy_instances("DeckCards");
	layer_destroy_instances("InventoryCards");
	createDeckWithOffset(global.Game.temp_deck_offset);
	createInventoryWithOffset(global.Game.temp_inventory_offset);
}