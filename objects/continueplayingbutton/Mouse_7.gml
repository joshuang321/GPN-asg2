pressed = false;
audio_play_sound(buttonClick, 0, false);
instance_activate_layer("Menu");
instance_activate_layer("Cards");
instance_activate_layer("Values");
instance_activate_layer("Instances");
instance_deactivate_layer("PauseMenu");
layer_set_visible("Pause", false);