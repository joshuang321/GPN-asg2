var _dmg = data.dmg;
var _self = id;
with(global.Game.level.playerInst)
{
	audio_play_sound(bossAttack, 0, false);
	startAnimation(boss_attack);
	dealDamage(_self, _dmg);
}