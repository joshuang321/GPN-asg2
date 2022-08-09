pressed = false;
audio_play_sound(buttonClick, 0, false);
instance_deactivate_layer("Menu");
instance_deactivate_layer("Cards");
instance_activate_layer("PauseMenu");
layer_set_visible("Pause", true);