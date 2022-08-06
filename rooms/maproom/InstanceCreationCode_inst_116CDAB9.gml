menu_string = "Stage 3";
stage = 2;
var _stage = global.Game.curLevel/5;
sprite_index = _stage < stage? sAnchorNotAvaliable:
	(_stage > stage? sAnchorCompleted:sAnchor);