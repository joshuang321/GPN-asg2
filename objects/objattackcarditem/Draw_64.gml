drawCard();
var _number = data.init_dmg + level * data.inc_step;
draw_sprite(blooddrop, 0, x-3, y);
drawCardNumber(_number);
drawCardCost();
drawCardLevel();
drawCardCostUpgrade();