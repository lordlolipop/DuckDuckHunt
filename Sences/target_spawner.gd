extends Node2D

@onready var timer: Timer = $Timer

@export var targets = preload("res://Sences/Targets/targets.tscn")





func spawn_targets():
	timer.wait_time = randf_range(0.4, 1)

	var target_instance = targets.instantiate()
	add_child(target_instance)
	
	var target_position = Vector2()
	target_position.y = randi_range(150, 330)
	target_position.x = randi_range(0, get_viewport_rect().size.x)
	
	target_instance.position = target_position
	target_instance.starting_pos = target_position
	if target_instance.position.x > get_viewport_rect().size.x / 2:
		target_instance.sprite_2d.flip_h = true


func _on_timer_timeout() -> void:
	spawn_targets()
