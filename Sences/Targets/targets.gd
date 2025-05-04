extends Area2D


@export_enum ("target", "duck", "bad_duck", "under_cover_bad_duck") var target_type: int

@export var minimum_speed: int = 100
@export var maximum_speed: int = 500



@onready var sfx_manager: AudioStreamPlayer = $sfx_manager
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var BadDuckTimer: Timer = $BadDuckTimer
@onready var ttk_timer: Timer = $TTKTimer
@onready var shoot_mark: Sprite2D = $ShootMark


var sfx:= [
preload("res://Assets/Sound/SFX/gun-shot-1-7069.mp3"), 
preload("res://Assets/Sound/SFX/duck-quacking-37392.mp3"),
preload("res://Assets/Sound/SFX/duck-quack-112941.mp3")
]

var sprites: = [
preload("res://Assets/PNG/Objects/target_red3_outline.png"),
preload("res://Assets/PNG/Objects/duck_outline_yellow.png"),
preload("res://Assets/PNG/Objects/bad_duck.png")
]

var starting_pos:= Vector2(0,0)
var speed = randi_range(minimum_speed, maximum_speed)
var score_value: int
var damege:= 1
var alive: bool = true


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
			ttk_timer.start(randf_range(3.4, 5))

		3:
			$Sprite2D.texture = sprites[1]
			BadDuckTimer.one_shot = true
			BadDuckTimer.wait_time = randf_range(3, 6)
			BadDuckTimer.start()
			var stike = get_node("StickWoodFixedOutline")
			stike.position.y += -20 
			
		


func _process(delta: float) -> void:
	movement_handle(delta)
	if position.x > get_viewport_rect().size.x + 50 or position.x < -50:
		if ttk_timer:
			ttk_timer.stop()
		queue_free()


func _input_event(viewport: Viewport, event: InputEvent, shape_index: int):
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and
		event.is_pressed()
	)
	
	if event_is_mouse_click:
		sfx_manager.stream = sfx[0]
		sfx_manager.play()
		
		if target_type == 1 or target_type == 3 and BadDuckTimer.time_left > 0.1:
			Global.health -= damege
			print("dmg on hiting duck")
			sfx_manager.stream = sfx[1]
			sfx_manager.volume_db = 10
			sfx_manager.play()
			if ttk_timer:
				ttk_timer.stop()

		Global.score += score_value
		alive = false
		visible = false
		await get_tree().create_timer(3).timeout
		sfx_manager.volume_db = -15
		queue_free()






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
	ttk_timer.start(randf_range(1, 3))
	print("TTK TIMER STARTED")
	shoot_mark.visible = true
	sfx_manager.stream = sfx[2]
	sfx_manager.volume_db = 30
	sfx_manager.play()
	sfx_manager.volume_db = -8
	
	var tween = create_tween()
	var original_scale = sprite_2d.scale
	tween.tween_property(sprite_2d, "scale", Vector2(1.2,1.2), 0.1)
	tween.tween_property(sprite_2d, "scale", original_scale, 0.1)
	
	var _ttk_tween = create_tween()
	for x in ttk_timer.time_left:
		_ttk_tween.tween_property(shoot_mark, "scale", Vector2(1.2,1.2), 0.4)
		_ttk_tween.tween_property(shoot_mark, "modulate", Color.RED, 0.3)
		_ttk_tween.tween_property(shoot_mark, "scale", Vector2(1.6,1.6), 0.4)
		_ttk_tween.tween_property(shoot_mark, "modulate", Color.WHITE_SMOKE, 0.3)

	
func _on_ttk_timer_timeout() -> void:
	if alive:
		Global.health -= damege
	
		sfx_manager.stream = sfx[0]
		sfx_manager.play()
		await get_tree().create_timer(1).timeout
		queue_free()
		print("dmg")
		
	else:
		ttk_timer.stop()
