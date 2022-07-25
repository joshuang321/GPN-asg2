#macro _LEVEL_FILENAME		"level.json"
#macro _LEVEL_VARNAME		"_level"

function load_level_data()
{
	global._level = load_json_data(_LEVEL_FILENAME, "Failed to load levels!",
		_LEVEL_FILENAME + "does not exists!",
		_LEVEL_VARNAME);
}