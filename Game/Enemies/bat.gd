extends Enemy


func _ready():
	current_hp = max_hp
	$AnimatedSprite2D.play("fly")
