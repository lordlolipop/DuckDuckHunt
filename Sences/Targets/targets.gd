extends Area2D


@export_enum ("target", "duck", "bad_duck") var target_type: int

@export var minimum_speed: int = 100
@export var maximum_speed: int = 500


var speed = randi_range(minimum_speed, maximum_speed)
var score_value: int = 1


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x + 100:
		print ("out of view")
		queue_free()
