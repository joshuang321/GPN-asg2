#macro _GAME_STATE_PLAYER	0
#macro _GAME_STATE_ENEMY	1
#macro _GAME_STATE_VICTORY	2
#macro _GAME_STATE_DEFEAT	3

function Room(_levelno) constructor
{
	turns_left = global.cur_player.skill_pts;
	enemy_selected = noone;
	game_state = _GAME_STATE_PLAYER;
	levelno = _levelno;
	
	for (var _i=0;
		_i<array_length(global._level);
		_i++)
	{
		if (_levelno == global._level[_i].levelno)
		{
			_enemy = array_create(array_length(global._level[_i].enemy));
			var _x = room_width - 298;
			var _y = room_height - 592;
			for (var _j=0;
				_j<array_length(global._level[_i].enemy);
				_j++)
			{
				_enemy[_j] = instance_create_layer(_x, _y,
					"Instances",
					enemy_obj,
					{
						_health : global._level[_i].enemy[_j].health,
						maxhealth : global._level[_i].enemy[_j].health,
						_id : global._level[_i].enemy[_j].id,
						_attack : global._level[_i].enemy[_j].attack,
						_block : global._level[_i].enemy[_j].block,
						attack_block_prob : global._level[_i].enemy[_j].attack_block_prob
					});
				_x -= 288;
			}
			break;
		}
	}
	
	_player = instance_create_layer(118, room_height -592,
		"Instances",
		player_obj,
		{
			maxhealth : global.cur_player.maxhealth,
			_health : global.cur_player._health
		});
	
	randomize();
	ds_list_shuffle(global.cur_player.cards);
	cards = ds_stack_create();
	for (var _i=0;
		_i<ds_list_size(global.cur_player.cards);
		_i++)
		ds_stack_push(cards,
		{
			_id : global.cur_player.cards[| _i]._id
		});
	chosen = array_create(4);
	pending = ds_list_create();
	
	static determine_intent = function()
	{
		for (var i = 0; i < instance_number(enemy_obj); ++i;)
		{
		   var __enemy = instance_find(enemy_obj ,i);
		   var _prob = random(1.0);
		   with (__enemy)
		   {
			   intent = _prob > attack_block_prob ? _CARD_ATK :
				_CARD_BLK;
				if (_CARD_BLK == intent)
					block += _block;
		   }
		}
	}
	
	static take_cards = function()
	{
		if (ds_stack_empty(cards))
		{
			show_debug_message("cards is empty! reshuffling cards..");
			ds_list_shuffle(pending);
			for (var _i=0;
				_i<ds_list_size(pending);
				_i++)
				ds_stack_push(cards, pending[| _i]);
			
			ds_list_clear(pending);
		}
		var _x = 280;
		var _y = room_height - 300;
		for (var _i=0;
			_i<4 && !ds_stack_empty(cards);
			_i++)
		{
			var _card = ds_stack_pop(cards);
			show_debug_message(_card);
			chosen[_i] =
			{ 
				card : _card,
				_id : instance_create_layer(_x, _y,
					"Instances",
					card_obj,
					_card)
			}
			_x += + 188;
		}
	}
	
	static use_card = function(__id)
	{
		var _enemy_selected = enemy_selected;
		var _turns_left = turns_left;
		var __player = _player;
		
		show_debug_message("use_card");
		with (__id)
		{
			if (_CARD_ATK == _id &&
				noone != _enemy_selected &&
				0 != _turns_left)
			{
				with (_enemy_selected)
				{
					var __block = block;
					__block -= 3;
					if (__block < 1)
					{
						_enemy_selected._health += __block;
						block = 0;
					}
					if (_enemy_selected._health < 0)
					{
						instance_destroy(_enemy_selected);
					}
				}
				instance_destroy(__id);
				_enemy_selected = noone;
				_turns_left--;
			}
			else if (_CARD_BLK == _id &&
				0 != _turns_left)
			{
				with (__player)
				{
					block += 3;
				}
				instance_destroy(__id);
				_turns_left--;
			}
		}
		enemy_selected = _enemy_selected;
		turns_left = _turns_left;
		
		if (0 == instance_number(enemy_obj))
			game_state = _GAME_STATE_VICTORY;
		
		show_debug_message(turns_left);
	}
	
	static do_intent = function()
	{
		var _net_damage = 0;
		for (var i = 0; i < instance_number(enemy_obj); ++i;)
		{
		    var __enemy = instance_find(enemy_obj, i);
			with (__enemy)
			{
				switch (intent)
				{
					case _CARD_ATK:
						_net_damage += _attack;
						break;
					
					case _CARD_BLK:
						block += _block;
						break;
				}
			}
		}
		
		with (_player)
		{
			var __block = block;
			var _is_dead = false;
			__block -= _net_damage;
			if (__block < 1)
			{
				_health += __block;
				block = 0;
			}
			if (_health < 0)
				_is_dead = true;
		}
		if (_is_dead)
		{
			instance_destroy(_player);
			game_state = _GAME_STATE_DEFEAT;
		}
	}
	
	static end_turn = function()
	{
		with(card_obj)
			instance_destroy(card_obj);
		for (var _i=0;
			_i< array_length(chosen);
			_i++)
			ds_list_add(pending, chosen[_i].card);
		turns_left = global.cur_player.skill_pts;
		game_state = _GAME_STATE_ENEMY;
		// enemy attack here
		
		do_intent();
		if (_GAME_STATE_DEFEAT == game_state)
			return noone;
		
		with (all)
			block = 0;
		game_state = _GAME_STATE_PLAYER;
		
		
		determine_intent();
		take_cards();
	}
	
	determine_intent();
	take_cards();
}

function destroy_room(_room)
{
	ds_stack_destroy(_room.cards);
	ds_list_destroy(_room.pending);
}

