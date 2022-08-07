audio_stop_all();
NewLevel(global.Game.curLevel);
instance_deactivate_layer("GameVictory");
instance_deactivate_layer("GameDefeat");
var _lvl = getLevel(global.Game.curLevel);
setBackground(_lvl);