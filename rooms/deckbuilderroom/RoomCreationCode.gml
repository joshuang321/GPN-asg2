audio_stop_all();
audio_play_sound(DeckBuilderBGM, 0, true);
instance_deactivate_object(inst_34134C65);
instance_deactivate_object(inst_41BBA979);
global.Game.temp_deck_offset = 0;
global.Game.temp_inventory_offset = 0;
createDeckWithOffset(0);
createInventoryWithOffset(0);