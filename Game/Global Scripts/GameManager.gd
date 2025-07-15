extends Node


var camera: Camera2D = null

signal hp_changed

var player_max_hp: int = 3
var player_hp: int = 3



func take_damage():
	if player_hp == 0:
		return
	
	player_hp -= 1
	player_hp = clamp(player_hp, 0, player_max_hp)
	emit_signal("hp_changed")
	
	
	if camera:
		camera.shake()
		
	player_die()
		
func player_die():
	if player_hp <= 0:
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
		

		
