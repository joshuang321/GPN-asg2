drawCard();

var _cardNumber = 100 * (data.init_percent_weaken +
	level * data.inc_step);

draw_sprite_stretched(cWeaken, 0, x + 6, y + 4, 35, 35);
drawCardNumber(_cardNumber);
drawNormalCardCost();
drawCardLevel();
drawCardCostUpgrade();