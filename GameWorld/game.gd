extends Node3D

var fuel = 100
var oxygen = 100

@export var fuel_label : Label
@export var oxygen_label : Label

@onready var power_off = [$CanvasLayer/ViewportFuel/Camera3D/PowerOff, $CanvasLayer/ViewportOxygen/Camera3D/PowerOff, $CanvasLayer/Viewport1/Camera3D/PowerOff]

func _ready() -> void:
	$GameLogic/AnimationPlayer.play("cctv_rot")

func update_ui():
	fuel_label.text = str(int(fuel)) + "%"
	oxygen_label.text = str(int(oxygen)) + "%"

func _on_timer_timeout() -> void:
	fuel -= 1
	if fuel <= 0:
		for i in range(0, $Lights.get_child_count()):
			$Lights.get_child(i).visible = false
		for i in range(0, power_off.size()):
			power_off[i].visible = true
		fuel = 0
	update_ui()
	$GameLogic/FuelTimer.start()

func _on_oxygen_timer_timeout() -> void:
	if oxygen == 0:
		return
	oxygen -= 1
	$GameLogic/OxygenTimer.start()
	update_ui()
