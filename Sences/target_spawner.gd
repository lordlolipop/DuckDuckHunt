extends Node2D

@onready var timer: Timer = $Timer

@export var targets = preload("res://Sences/Targets/targets.tscn")





func spwan_targets():
	timer.wait_time = randf_range(0.4, 5)
	timer.start()

	var _target_instenc = targets.instantiate()
	add_child(_target_instenc)
	var target_positon = Vector2(0,0)
	target_positon.y = randi_range(220, 400)
	_target_instenc.position = target_positon


func _on_timer_timeout() -> void:
	spwan_targets()
