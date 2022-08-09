global.Game.level.enemyTurn = id;
var _dmg = data.dmg;
var _self = id;
if (!hasBuffed &&
	curhealth/maxhealth <= data.reflect_at)
{
	addEffect("Reflective", { attacks: 
		data.attacks });
	startAnimation(buff);
}
else
{
	with(global.Game.level.playerInst)
	{
		audio_play_sound(bossAttack, 0, false);
		startAnimation(boss_attack);
		dealDamage(_self, _dmg);
	}
}