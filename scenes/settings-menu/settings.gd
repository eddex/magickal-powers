extends Control

var initialized := false
signal on_settings_closed()

func _ready() -> void:
	%MusicHSlider.value = G.music_volume
	%SfxHSlider.value = G.sfx_volume

func _on_music_h_slider_value_changed(value: float) -> void:
	G.update_music_volume(value as int)

func _on_exit_button_pressed() -> void:
	close()

func _on_ok_button_pressed() -> void:
	close()

func close() -> void:
	hide()
	on_settings_closed.emit()

func _on_sfx_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		G.update_sfx_volume(%SfxHSlider.value)
		$SfxAudioStreamPlayer.play()
