extends Label

func _process(delta: float) -> void:
	var _health = str(Global.health)
	self.text = str("health" + _health)
