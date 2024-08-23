extends CharacterBody2D

var VehicleHandling : int = 20
var VehicleAcceleration : float = 1
var VehicleTopSpeed : float = 250
var GearCount : int = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

var TurningSpeed : int = 0
var Throttle : int = 0

var Velocity : float = 0

var Friction : float = 0.1
var WaterFriction : float = 0.5

var InWater : int = 0

var WaterTime = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if InWater == 1: WaterTime += (delta * WaterFriction)
	rotation_degrees += deg_to_rad(TurningSpeed) * delta * Velocity
	Velocity = clamp(Velocity + (Throttle) - (Friction * sign(Velocity)), -VehicleTopSpeed / GearCount, VehicleTopSpeed / (pow(GearCount, InWater) * clamp(WaterTime, 0, 1)))
	position += (transform.y * Velocity * delta)
	pass

func _input(event : InputEvent):
	if event.is_action_pressed("LeftPlr1") or event.is_action_released("RightPlr1"):
		TurningSpeed -= VehicleHandling
	if event.is_action_released("LeftPlr1") or event.is_action_pressed("RightPlr1"):
		TurningSpeed += VehicleHandling
		
	if event.is_action_pressed("ForwardPlr1") or event.is_action_released("ReversePlr1"):
		Throttle += 1
	if event.is_action_released("ForwardPlr1") or event.is_action_pressed("ReversePlr1"):
		Throttle -= 1
	pass
	

func _on_water_body_entered(body: Node2D) -> void:
	InWater = 1
	pass # Replace with function body.


func _on_water_body_exited(body: Node2D) -> void:
	WaterTime = 0
	InWater = 0
	pass # Replace with function body.
