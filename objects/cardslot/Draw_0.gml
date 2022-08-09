draw_set_color(global.GameConfig.max_card_slot>ds_list_size(global.Game.player_card)?
	#FF4500 : #FFFFFF);
draw_set_font(global.uiFont);
draw_centered(string(ds_list_size(global.Game.player_card)));