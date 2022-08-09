global.Game.level.enemyTurn = id;
var _dmg = data.dmg;
var _self = id;
with(global.Game.level.playerInst)
{
	audio_play_sound(ifritAttack, 0, false);
	startAnimation(ifrit_attack);
	dealDamage(_self, _dmg);
}