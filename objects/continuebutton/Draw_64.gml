drawPressed();
var _curParagraph = global.Game.curLevel == array_length(global.GameLevel) ? global.GameConfig.final_cutscene.paragraphs :
	global.GameConfig.story[global.Game.curLevel div 5].paragraphs;
draw_text_ext(75, 200, _curParagraph[global.Game.storyIndex-1].text, 40, 1075);