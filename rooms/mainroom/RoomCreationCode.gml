load_config_data();
load_level_data();

show_debug_message(string(global._config));
show_debug_message(string(global._level));
show_debug_message(string(global.cur_player));
for (var _i=0;
	_i<ds_list_size(global.cur_player.cards);
	_i++)
	show_debug_message(global.cur_player.cards[| _i]);