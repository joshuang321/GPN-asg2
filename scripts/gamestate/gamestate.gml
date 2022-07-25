function load_json_data(_filename, _load_fails_dmessage,
	_file_dnexists_dmessage, _global_var_str)
{
	if (file_exists(_filename))
	{
		var _buffer = buffer_load(_filename);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		var _data = json_parse(_string);
		if (-1 == _data)
			show_debug_message(_load_fails_dmessage);
		else
			return _data;
	}
	else {
		show_debug_message(_file_dnexists_dmessage);
	}
	return noone;
}