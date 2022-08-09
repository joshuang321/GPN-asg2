global.Game.level.enemyTurn = id;
var _dmg = data.dmg;
var _self = id;
var _numcards = data.numcards;
var _burning_dmg = data.burning_dmg;
var _turns = data.turns;

if (!hasUsed &&
	curhealth/maxhealth < data.apply_at)
{
	hasUsed = true;
	audio_play_sound(ifritSkill, 0, false);
	with (global.Game.level.playerInst)
		addEffect("Burned", { numcards : _numcards,
			burning_dmg : _burning_dmg,
			turns : _turns });
}
else
{
	with(global.Game.level.playerInst)
	{
		audio_play_sound(ifritAttack, 0, false);
		startAnimation(ifrit_attack);
		dealDamage(_self, _dmg);
	}
}