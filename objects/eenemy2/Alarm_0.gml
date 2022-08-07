var _dmg = data.dmg;
var _self = id;
with(global.Game.level.playerInst)
{
	audio_play_sound(mageAttack, 0, false);
	startAnimation(enemy_bash);
	dealDamage(_self, _dmg);
}