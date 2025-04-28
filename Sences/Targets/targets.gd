extends Area2D


@export_enum ("target", "duck", "bad_duck") var target_type: int

@export var minimum_speed: int = 100
@export var maximum_speed: int = 500
@onready var sprite_2d: Sprite2D = $Sprite2D


var sptites: = [preload("res://Assets/PNG/Objects/target_red3_outline.png"),
preload("res://Assets/PNG/Objects/duck_outline_yellow.png"),
preload("res://Assets/PNG/Objects/bad_duck.png")
]

var starting_pos:= Vector2(0,0)
var speed = randi_range(minimum_speed, maximum_speed)
var score_value: int
var damege:= 1



func _ready() -> void:
	target_type = randi_range(0,2)
	match target_type:
		0:
			score_value = 1
			$Sprite2D.texture = sptites[0]
		1: 
			score_value = 0
			$Sprite2D.texture = sptites[1]
			var stike = get_node("StickWoodFixedOutline")
			stike.position.y += -20 
		2: 
			$Sprite2D.texture = sptites[2]
			$Sprite2D.scale = Vector2(0.31, 0.31)
			score_value = 5



func _process(delta: float) -> void:
	movment_handel(delta)
	if position.x > get_viewport_rect().size.x + 100 or position.x < -50:
		print ("out of view")
		queue_free()


func _input_event(viewport: Viewport, event: InputEvent, shape_index: int):
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and
		event.is_pressed()
	)
	
	if event_is_mouse_click:
		if target_type == 1:
			Global.health -= damege
			
		queue_free()
		Global.score += score_value



func movment_handel(delta):
	if starting_pos.x < get_viewport_rect().size.x / 2:
		position.x += speed * delta 
	else:
		position.x += speed * delta * -1
	print(starting_pos)
  
