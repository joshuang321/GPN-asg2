drawPressed();
draw_set_color(#000000);
draw_set_font(global.uiSmallFont);

draw_text_ext(75, 200, global.GameConfig.story[floor(
	global.Game.curLevel/5)].text, 40, 1075);