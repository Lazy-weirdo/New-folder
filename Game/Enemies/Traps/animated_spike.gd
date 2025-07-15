extends Area2D

var player_inside : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("appear")



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.take_damage()
		player_inside = true
		$DamageTimer.start()
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		$DamageTimer.stop()


func _on_damage_timer_timeout() -> void:
	if player_inside:
		GameManager.take_damage()
