drawCard();

var _cardNumber = data.init_dmg + level * data.inc_step;
draw_sprite_stretched(blooddrop, 0, x + 6, y + 4, 35, 35);
drawCardNumber(_cardNumber);
drawNormalCardCost();
drawCardLevel();