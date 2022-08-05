var _dmg = data.dmg;
with(global.Game.level.playerInst)
{
	audio_play_sound(enemyBash, 0, false);
	startAnimation(enemy_bash);
	dealDamage(_dmg);
}