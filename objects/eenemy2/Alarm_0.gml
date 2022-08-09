global.Game.level.enemyTurn = id;
var _dmg = data.dmg;
var _self = id;

var _extra_cost = data.extra_cost;
var _turns = data.turns;

if (!hasUsed &&
	curhealth/maxhealth < data.apply_at)
{
	hasUsed = true;
	audio_play_sound(mageSkill, 0, false);
	with (global.Game.level.playerInst)
		addEffect("Hypnotized", { extra_cost : _extra_cost,
			turns : _turns });
}
else
{
	with(global.Game.level.playerInst)
	{
		audio_play_sound(mageAttack, 0, false);
		startAnimation(mage_attack);
		dealDamage(_self, _dmg);
	}
}