#macro X_NUM_OFFSET		5
#macro Y_NUM_OFFSET		5

drawCard();
var _number = data.init_dmg + level * data.inc_step;
draw_sprite(blooddrop, 0, x-3, y);
drawCardNumber(ceil(_number));
drawCardCost();