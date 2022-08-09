drawPressed();
draw_set_color(#000000);
draw_set_font(global.uiSmallFont);

var _curParagraph = global.Game.curLevel == array_length(global.GameLevel) ? global.GameConfig.final_cutscene.paragraphs :
	global.GameConfig.beginning_cutscene.paragraphs;
draw_text_ext(75, 200, _curParagraph[global.Game.storyIndex-1].text, 40, 1075);