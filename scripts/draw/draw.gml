#macro CARD_Y_OFFSET 55

function drawPressed()
{
	if (pressed)
	{	
		draw_set_alpha(0.3);
		draw_set_colour(#000000);
		draw_rectangle(x, y, x + sprite_width,
			y + sprite_height, false);
		draw_set_alpha(1.0);
	}
}

function drawCard()
{
	var _sprite_asset = asset_get_index(sprite);
	var _sprite_info = sprite_get_info(_sprite_asset);
	draw_sprite(_sprite_asset, 0, x + sprite_width/2 - _sprite_info.width/2,
		y+ sprite_height/2 - _sprite_info.height/2 -CARD_Y_OFFSET);
	drawPressed();
}

function drawCardNumber(_number)
{
	draw_set_font(global.uiSmallFont);
	draw_set_color(#CCCCCC);
	draw_text(x + X_NUM_OFFSET + 3, y + Y_NUM_OFFSET + 2,
		_number);
}

function drawCardCost()
{
	var _cardCost = card_cost.init + level * card_cost.inc_step;
	draw_set_font(global.uiSmallFont);
	draw_set_color(#000000);
	var _x = x + sprite_width - X_NUM_OFFSET - 20;
	var _y =  y + Y_NUM_OFFSET, _cardCost;
	
	draw_sprite_stretched(sEnergy, 0, _x-10, _y, 35, 35);
	draw_text(_x, _y, _cardCost);
}

#macro _HEALTHBAR_WIDTH		180

function drawhealthbar(cur_health, m_health, _x, _y, _s_width, _block)
{
	var dif = (_s_width -_HEALTHBAR_WIDTH)/2;
	draw_healthbar(_x + dif, _y - 30, _x + _s_width - dif, _y -10, (cur_health/m_health) * 100,
		#434f46, #ff1500,
		#3cff00, 0,
		true, true);
	draw_set_colour(#FFFFFF);
	draw_set_font(global.uiVerySmallFont);
	_y -= 35;
	if (0 != _block)
	{
		draw_sprite_stretched(cBlock, 0, _x -19, _y, 30, 30);
		draw_text(_x - 8, _y +3, string(_block));
	}
	_x += _s_width - dif + 12;
	draw_sprite(heart, 0, _x, _y);
	draw_text(_x + 6, _y +3, string(cur_health));
}

#macro FLOAT_MAG		10
#macro SPACING			(2 * FLOAT_MAG + 75)

function drawSelected()
{
	if (variable_instance_exists(id, "time") &&
		id == global.Game.level.enemySelected)
	{
		var _spriteSelectInfo = sprite_get_info(sEnemySelect);
		var _channel = animcurve_get_channel(floatingSelectAnimation, 0);		
		time = (time + 0.01) mod 1;
		var _y = y - SPACING  - animcurve_channel_evaluate(_channel, time)
			* FLOAT_MAG;
		draw_sprite(sEnemySelect, 0, x + sprite_width/2 - _spriteSelectInfo.width/2, _y);
	}
	
}

function drawAnimation()
{
	if (variable_instance_exists(id, "animated_sprite_index") &&
		noone != animated_sprite_index)
	{
		var _spriteinfo = sprite_get_info(animated_sprite_index);
		if (image_index < sprite_get_number(animated_sprite_index))
		{
			draw_sprite(animated_sprite_index, image_index,
				x + sprite_width/2 - _spriteinfo.width/2,
				y + sprite_height/2 - _spriteinfo.height/2);
			image_index++;
		}
		else
		{
			image_index = 0;
			animated_sprite_index = noone;
		}
	}
}

function startAnimation(_animated_sprite_index)
{
	image_index = 0;
	animated_sprite_index = _animated_sprite_index;
}

function drawMainMenuButton()
{
	draw_set_font(global.uiSmallFont);
	draw_text(x + sprite_width/2 - string_width(menu_string)/2, y, menu_string);
}

#macro MAP_MENU_Y_GAP	10
function drawMapMenuButton()
{
	draw_set_color(#F6BE00);
	draw_set_font(global.uiSmallFont);
	draw_text(x + sprite_width/2 - string_width(menu_string)/2,
		y + sprite_height + MAP_MENU_Y_GAP, menu_string);
}
	