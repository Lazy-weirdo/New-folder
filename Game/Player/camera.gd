extends Camera2D

var shake_strength := 5.0
var shake_duration := 0.2
var shake_timer := 0.0

func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = Vector2.ZERO

func shake():
	shake_timer = shake_duration
