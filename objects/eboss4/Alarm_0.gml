var _dmg = data.dmg;
var _self = id;
with(global.Game.level.playerInst)
{
	audio_play_sound(deathAttack, 0, false);
	startAnimation(death_attack);
	dealDamage(_self, _dmg);
}