#macro _CARD_BLK	1
#macro _CARD_ATK	2

if (_CARD_BLK == _id)
{
	draw_sprite(card_block_bkgnd, 0, x, y);
	draw_sprite(blk, 0, x+48, y+28);
}
else if (_CARD_ATK == _id)
{
	draw_sprite(card_attack_bkgnd, 0, x, y);
	draw_sprite(atk, 0, x+48, y+28);
}