draw_sprite(_cardDeck, 0, x, y);
draw_set_color(#000000);

draw_set_font(global.uiFont);
draw_text(x + 24, y - 35, string(ds_stack_size(global.Game.level.player_stack)));
draw_set_color(#FFFFFF);
draw_text(x + 27, y -35, string(ds_stack_size(global.Game.level.player_stack)));