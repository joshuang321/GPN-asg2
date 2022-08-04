#macro _CARD_TYPE_HEAL	3
drawCard();
switch (card_id)
{
	case _CARD_TYPE_HEAL:
		var _cardNumber = data.init_heal + (variable_instance_exists(id, "level")?
			level : 0) * data.inc_step;
		drawCardNumber(_cardNumber);
		break;
	
}

drawCardCost();