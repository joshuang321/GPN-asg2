menu_string = "Stage 1";
stage = 0;
var _stage = global.Game.curLevel/5;
sprite_index = _stage < stage? sAnchorNotAvaliable:
	(_stage > stage? sAnchorCompleted:sAnchor);