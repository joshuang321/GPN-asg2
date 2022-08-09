drawCard();

var _cardNumber = 100 * (data.init_percent_exhaust +
	level * data.inc_step);

draw_sprite_stretched(cExhaust, 0, x + 6, y + 4, 35, 35);
drawCardNumber(ceil(_cardNumber));
drawCardCost();
drawCardLevel();
drawCardCostUpgrade();