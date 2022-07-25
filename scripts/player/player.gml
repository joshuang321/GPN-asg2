function Player(_player_struct) constructor
{
	maxhealth = _player_struct._health;
	_health = maxhealth;
	skill_pts = _player_struct.skill_pts;
	cards = ds_list_create();
	
	for (var _i=0;
		_i<array_length(_player_struct.cards);
		_i++)
	{
		ds_list_add(cards,
			{
				_id  : _player_struct.cards[_i]._id,
			});
	}
}

function destroy_player(_player)
{
	ds_list_destroy(_player.cards);
	delete _player;
}