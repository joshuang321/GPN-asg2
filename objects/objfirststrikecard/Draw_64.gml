drawCard();

var _cardNumber = 0;
if (noone != global.Game.level.enemySelected)
{
	var _enemy_health = 0;
	var _health_percent_offset = data.health_percent_offset;
	with (global.Game.level.enemySelected)
		_enemy_health = curhealth - (maxhealth * _health_percent_offset);
	_cardNumber =  max(0, _enemy_health) * (data.init_percent_dmg +
		level * data.inc_step)
}

draw_sprite_stretched(blooddrop, 0, x + 6, y + 4, 35, 35);
drawCardNumber(ceil(_cardNumber));
drawCardCost();