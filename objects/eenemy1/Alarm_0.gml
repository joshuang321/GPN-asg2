global.Game.level.enemyTurn = id;
var _dmg = data.dmg;
var _self = id;
with(global.Game.level.playerInst)
{
	startAnimation(enemy_bash);
	dealDamage(_self, _dmg);
}
show_debug_message(global.Game.level.playerInst);
audio_play_sound(enemyBash, 0, false);