extends Label

func _process(delta: float) -> void:
	var _score = str(Global.score)
	self.text = str("score " + _score)
