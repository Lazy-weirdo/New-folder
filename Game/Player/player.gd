class_name Player extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
var is_hurt := false

var knockback_impulse := Vector2.ZERO
var knockback_velocity := Vector2.ZERO
var knockback_time := 0.1


const SPEED = 100.0
const RUN_SPEED = 170.0
const JUMP_VELOCITY = -215.0
const GRAVITY = 500.0

func _ready() -> void:
	GameManager.hp_changed.connect(_on_player_hurt)
	GameManager.camera = $Camera2D

func _physics_process(delta: float) -> void:

	if is_hurt:
		velocity = knockback_impulse
		knockback_impulse = Vector2.ZERO  
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement input
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		animation.flip_h = direction < 0
		if Input.is_action_pressed("run"):
			velocity.x = direction * RUN_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		animation.play("jump")
	elif direction != 0:
		if Input.is_action_pressed("run"):
			animation.play("run") 
		else:
			animation.play("walk")
	else:
		animation.play("idle")

	move_and_slide()

func _on_player_hurt():
	is_hurt = true
	$HurtSound.play()
	animation.play("hurt")

	animation.modulate = Color(2, 2, 2)
	await get_tree().create_timer(0.05).timeout
	animation.modulate = Color(1, 1, 1, 1)

	var knock_dir := 1 if animation.flip_h else -1

	knockback_impulse = Vector2(knock_dir * 250, -200)

	await get_tree().create_timer(0.2).timeout
	is_hurt = false
