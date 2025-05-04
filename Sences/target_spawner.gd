extends Node2D

@onready var timer: Timer = $Timer

@export var targets = preload("res://Sences/Targets/targets.tscn")
@export var y_pos : int = 200
@export var scalemultiplayer := Vector2(1, 1)
@export var max_spawn_count: int = 1
@export var minimum_time_to_spawn : float = 1.0


func _ready() -> void:
	max_spawn_count += 1

func spawn_targets():
	if get_child_count() >= max_spawn_count:
		return
	timer.wait_time = randf_range(minimum_time_to_spawn, 2)

	var target_instance = targets.instantiate()
	add_child(target_instance)

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

# TTS = Time to spawn
func _on_tts_timer_timeout() -> void:
	minimum_time_to_spawn -= 0.1
	max_spawn_count += 1
