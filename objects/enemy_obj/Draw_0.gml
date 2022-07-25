draw_sprite(enemy, 0, x, y);
drawhealthbar(_health, maxhealth, x, y, sprite_width, block);

if (id == global._room.enemy_selected)
	draw_sprite_stretched(select_frame, 0, x, y, sprite_width,
		sprite_height);