extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Sences/Main_level/main_level.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_audio_stream_player_finished() -> void:
	audio_stream_player.start()
