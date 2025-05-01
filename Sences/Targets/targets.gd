extends Area2D


@export_enum ("target", "duck", "bad_duck", "under_cover_bad_duck") var target_type: int

@export var minimum_speed: int = 100
@export var maximum_speed: int = 500
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var BadDuckTimer: Timer = $BadDuckTimer
@onready var ttk_timer: Timer = $TTKTimer



var sprites: = [preload("res://Assets/PNG/Objects/target_red3_outline.png"),
preload("res://Assets/PNG/Objects/duck_outline_yellow.png"),
preload("res://Assets/PNG/Objects/bad_duck.png")
]

var starting_pos:= Vector2(0,0)
var speed = randi_range(minimum_speed, maximum_speed)
var score_value: int
var damege:= 1



func _ready() -> void:
	randomize()
	target_type = randi_range(0,3)
	starting_pos = position
	match target_type:
		0:
			score_value = 1
			$Sprite2D.texture = sprites[0]
		1: 
			score_value = 0
			$Sprite2D.texture = sprites[1]
			var stike = get_node("StickWoodFixedOutline")
			stike.position.y += -20 
		2: 
			$Sprite2D.texture = sprites[2]
			$Sprite2D.scale = Vector2(0.31, 0.31)
			score_value = 1
			ttk_timer.start(randi_range(2, 5))

		3:
			$Sprite2D.texture = sprites[1]
			BadDuckTimer.one_shot = true
			BadDuckTimer.wait_time = randf_range(0.7, 4)
			BadDuckTimer.start()
			var stike = get_node("StickWoodFixedOutline")
			stike.position.y += -20 
			
		


func _process(delta: float) -> void:
	movement_handle(delta)
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
		if target_type == 1 :
			Global.health -= damege
			
		queue_free()
		Global.score += score_value



func movement_handle(delta):
	if target_type == 3:
		if BadDuckTimer.time_left > 0:
			if starting_pos.x <= get_viewport_rect().size.x / 2:
				position.x += speed * delta
			else:
				position.x -= speed * delta
		# else: do nothing, duck stops
	else:
		if starting_pos.x <= 640:
			position.x += speed * delta
		else:
			position.x -= speed * delta

	


func _on_bad_duck_timer_timeout() -> void:
	sprite_2d.texture = sprites[2]
	sprite_2d.scale = Vector2(0.31, 0.31)
	ttk_timer.start(randf_range(0.8, 2))



func _on_ttk_timer_timeout() -> void:
	Global.health -= 1
	queue_free()
