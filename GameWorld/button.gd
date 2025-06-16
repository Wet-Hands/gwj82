extends Area3D

func change_cam():
	$"../../../CanvasLayer/Viewport1".change_cam()
	$AudioStreamPlayer3D.play()
	$"../AnimationPlayer".play("button") #"The degrees to which the game recognizes and responded to the player's choices and actions" - Gabe Newell

func change_temp():
	pass
