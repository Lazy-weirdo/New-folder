extends CanvasLayer


const HP = preload("res://Game/GUI/HP.tscn")


func _ready():
	GameManager.connect("hp_changed", Callable(self, "update_hearts"))
	GameManager.player_hp = GameManager.player_max_hp
	update_hearts()
	

func update_hearts():
	var container = $HPContainer
	for child in container.get_children():
		child.queue_free()

	var max_hp = GameManager.player_max_hp
	var current_hp = GameManager.player_hp

	for i in max_hp:
		var heart = HP.instantiate()
		var is_filled = i < current_hp
		heart.set_filled(is_filled)
		container.add_child(heart)
