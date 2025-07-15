extends CharacterBody2D
class_name Enemy

@export var max_hp := 1
@export var move_speed := 50
var current_hp := 1
var direction := -1  


func _physics_process(delta):
	velocity.x = direction * move_speed
	move_and_slide()

	
	if is_on_wall():
		direction *= -1
		$AnimatedSprite2D.flip_h = direction > 0

func take_damage(amount: int):
	current_hp -= amount
	if current_hp <= 0:
		die()

func die():
	queue_free()


func _on_damage_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.take_damage()
