#macro X_NUM_OFFSET		5
#macro Y_NUM_OFFSET		5

drawCard();
var _number = data.init_dmg + (variable_instance_exists(id, "level") ?
	level : 0) * data.inc_step;
draw_sprite(blooddrop, 0, x, y);
drawCardNumber(_number);
drawCardCost();