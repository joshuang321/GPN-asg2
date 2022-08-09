global.Game.level.enemyTurn = id;
var _dmg = data.dmg;
var _self = id;
with(global.Game.level.playerInst)
{
	audio_play_sound(socererAttack, 0, false);
	startAnimation(socerer_attack);
	dealDamage(_self, _dmg);
}