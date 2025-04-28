extends Node



var score: int
var health:= 3

func _process(delta: float) -> void:
	if health <= 0:
		get_tree().quit()
