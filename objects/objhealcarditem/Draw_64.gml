drawCard();
var _cardNumber = data.init_heal + level * data.inc_step;
	
draw_sprite(cross, 0, x +5, y+10);
drawCardNumber(_cardNumber);

drawNormalCardCost();
drawCardLevel();
drawCardCostUpgrade();