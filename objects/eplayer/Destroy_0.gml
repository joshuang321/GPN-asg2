entityDestroy();
if (global.Game.level.gameState == _GAMESTATE_ENEMY)
{
	audio_play_sound(playerDeath, 0, false);
	with(inst_1FB0A37B)
		alarm[1] = -1;
	startNewGameState(_GAMESTATE_DEFEAT);
}