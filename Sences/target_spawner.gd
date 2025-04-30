extends Node2D

@onready var timer: Timer = $Timer

@export var targets = preload("res://Sences/Targets/targets.tscn")
@export var y_pos : int = 200
@export var scalemultiplayer := Vector2(1, 1)



func spawn_targets():
	timer.wait_time = randf_range(0.4, 3)

	var target_instance = targets.instantiate()
	add_child(target_instance)

	print(target_instance.target_type)

	var target_position = Vector2()
	target_position.y = y_pos
	target_position.x = randi_range(0, get_viewport_rect().size.x)
	
	target_instance.position = target_position
	target_instance.starting_pos = target_position
	if target_instance.position.x > get_viewport_rect().size.x / 2:
		target_instance.sprite_2d.flip_h = true
	target_instance.scale = scalemultiplayer
		
func _on_timer_timeout() -> void:
	spawn_targets()
