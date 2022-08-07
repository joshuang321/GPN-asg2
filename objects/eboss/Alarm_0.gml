var _dmg = data.dmg;
var _self = id;
with(global.Game.level.playerInst)
{
	audio_play_sound(enemyBash, 0, false);
	startAnimation(enemy_bash);
	dealDamage(_self, _dmg);
}