drawCard();

var _cardNumber = 0;

var _dmg = 0;
var _data = data;
with (global.Game.level.playerInst)
	var _health = maxhealth * _data.health_percent_offset - curhealth;

_cardNumber =  max(0, _health) * (data.init_percent_dmg +
	level * data.inc_step);

draw_sprite_stretched(blooddrop, 0, x + 6, y + 4, 35, 35);
drawCardNumber(ceil(_cardNumber));
drawCardCost();