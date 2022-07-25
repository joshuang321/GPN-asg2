#macro _HEALTHBAR_WIDTH		180

function drawhealthbar(cur_health, m_health, _x, _y, _s_width, _shield)
{
	var dif = (_s_width -_HEALTHBAR_WIDTH)/2
	draw_healthbar(_x + dif, _y - 50, _x + _s_width - dif, _y -30, (cur_health/m_health) * 100,
		#434f46, #ff1500,
		#3cff00, 0,
		true, true);
	draw_set_colour(#000000);
	draw_text(_x + _s_width - dif + 15, _y - 50, string(cur_health));
	draw_set_colour(#0000FF);
	if (0 != _shield)
		draw_text(_x - 17, _y - 50, string(_shield));
}