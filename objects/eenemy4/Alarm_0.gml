global.Game.level.enemyTurn = id;
var _dmg = data.dmg;
var _self = id;
var _miss_prob = data.miss_probability;
var _turns = data.turns;

if (!hasUsed &&
	curhealth/maxhealth < data.apply_at)
{
	hasUsed = true;
	audio_play_sound(ghostSkill, 0, false);
	with (global.Game.level.playerInst)
		addEffect("Darkened", { miss_probability : _miss_prob,
			turns : _turns });
}
else
{
	with(global.Game.level.playerInst)
	{
		audio_play_sound(ghostAttack, 0, false);
		startAnimation(ghost_attack);
		dealDamage(_self, _dmg);
	}
}