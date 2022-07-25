#macro _CONFIG_FILENAME		"config.json"
#macro _CONFIG_VARNAME		"_config"

function Config(_config_struct) constructor
{
	starting_player = 
	{
		_health : _config_struct._starting_player.health,
		skill_pts : _config_struct._starting_player.skill_pts,
		cards : array_create(array_length(_config_struct._starting_player.cards))
	};
	for (var _i=0;
		_i<array_length(_config_struct._starting_player.cards);
		_i++)
	{
		starting_player.cards[_i] =
		{
			_id : _config_struct._starting_player.cards[_i].id,
		};
	}
	
	card = _config_struct._card;
	_enemy = _config_struct._enemy;
}

function destroy_config(_config)
{
	ds_list_destroy(_config.starting_player.cards);
	delete _config;
}

function load_config_data()
{
	var _config = load_json_data(_CONFIG_FILENAME, "Failed to load config!",
		_CONFIG_FILENAME + " does not exists!",
		_CONFIG_VARNAME);
	global._config = new Config(_config);
	global.cur_player = new Player(global._config.starting_player);
}