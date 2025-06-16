extends SubViewport

var current_cam_num : int = 1
var cam_list

func _ready() -> void:
	cam_list = get_children()

func change_cam():
	if current_cam_num == cam_list.size():
		current_cam_num = 1
	else:
		current_cam_num += 1
	for i in range(0, cam_list.size()):
		cam_list[i].current = false
	cam_list[current_cam_num-1].current = true
	$Camera3D/Label.text = "CAM 00" + str(current_cam_num)
