extends Node2D


func _ready():
	
	var camera = GameManager.camera
	
	var top_left = $CameraLimits/TopLeft.global_position
	var bottom_right = $CameraLimits/BottomRight.global_position
	
	camera.limit_left = int(top_left.x)
	camera.limit_top = int(top_left.y)
	camera.limit_right = int(bottom_right.x)
	camera.limit_bottom = int(bottom_right.y)
