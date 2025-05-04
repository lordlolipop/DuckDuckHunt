extends Node2D



@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	Global.health = 3
	
	
func _process(delta: float) -> void:
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Sences/main_menu.tscn")


func _on_audio_stream_player_finished() -> void:
	audio_stream_player.play()
