drawCard();
var _number = data.init_block + level * data.inc_step;
draw_sprite_stretched(cBlock, 0, x, y+10, 35, 35);
drawCardNumber(_number);
drawNormalCardCost();
drawCardLevel();
drawCardCostUpgrade();