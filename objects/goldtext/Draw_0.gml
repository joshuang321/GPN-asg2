draw_set_font(global.uiSmallFont);
var _goldtxt = "You have earned " + string(amt);
var _goldtxtlen = string_width(_goldtxt) + 15 + sprite_width;
var _x = room_width/2 - _goldtxtlen/2;
draw_text(_x, y, _goldtxt);
_x += string_width(_goldtxt) + 15;
draw_sprite(sprite_index, 0, _x, y-sprite_height/2 + 15);

