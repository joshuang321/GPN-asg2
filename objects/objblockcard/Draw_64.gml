drawCard();
var _number = data.init_block + (variable_instance_exists(id, "level")
	? level : 0) * data.inc_step; 
drawCardNumber(_number);
drawCardCost();