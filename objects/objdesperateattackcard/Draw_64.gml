drawCard();

var _cardNumber = 0;

var _dmg = 0;
var _data = data;
with (global.Game.level.playerInst)
	var _health = (maxhealth  - curhealth) / maxhealth;

_cardNumber = (1-_health) * (data.init_dmg +
	level * data.inc_step);

draw_sprite_stretched(blooddrop, 0, x + 6, y + 4, 35, 35);
drawCardNumber(ceil(_cardNumber));
drawCardCost();