pressed = false;
audio_play_sound(buttonClick, 0, false);
destroyCurrentLevel();
global.Game.curLevel++;
room_restart();