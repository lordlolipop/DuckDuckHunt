extends Node2D


func _ready() -> void:
	Global.health = 3
	
	
func _process(delta: float) -> void:
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Sences/main_menu.tscn")
