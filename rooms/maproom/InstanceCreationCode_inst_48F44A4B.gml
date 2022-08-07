menu_string = "Stage 2";
stage = 1;
var _stage = floor(global.Game.curLevel/5);
sprite_index = _stage < stage? sAnchorNotAvaliable:
	(_stage > stage? sAnchorCompleted:sAnchor);