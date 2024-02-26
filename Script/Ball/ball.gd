class_name Ball
extends CharacterBody2D

@export_category("Ball Parameters")
@export var radius : int = 20
@export var speed : int = 1
@export var targetPosition : Vector2
@export var isFlying : bool = false
@export var orbitSpeedMult : float = 0.3

@onready var BallSprite : Sprite2D = $BallSprite
@onready var SphereSprite : Sprite2D = $StateMachine/SphereState/SphereForm
@onready var IcecleSprite : Sprite2D = $StateMachine/IcicleState/IcicleForm # (TODO) TEMP
@onready var flyTimer : Timer = $FlyTimer
@onready var hitbox : Area2D = $Hitbox

@onready var d := 0.0

var ballForm : bool = true
var icecleForm : bool = false
var readyToFly : bool = true
var distanceToTarget : float
var player : CharacterBody2D
var flyingDirection : int = 1
 
var p : float = 0.0

func set_player(playerToSet : CharacterBody2D):
	player = playerToSet

func _process(delta: float) -> void:
	targetPosition = player.position
	if ballForm:
		BallSprite.texture = SphereSprite.texture
	else:
		BallSprite.texture = IcecleSprite.texture
	# BallSprite.visible = true
	p += delta
	if flyTimer.is_stopped():
		flyOnOrbit()
	else:
		flyToDirection()

func changeSprite(newSprite : Sprite2D):
	BallSprite.texture = newSprite.texture

func startFlying():
	print("StartFlying", global_position)
	global_position = player.global_position
	print(global_position)
	global_position.x += radius
	if player.animation.flip_h:
		BallSprite.flip_h = true
		flyingDirection = -1
	else:
		BallSprite.flip_h = false
		flyingDirection = 1
	flyTimer.start()
	changeForm()
	readyToFly = false

func flyToDirection():
	global_position.x += speed * flyingDirection

func getDistanceToTarget() -> float:
	return float(sqrt(pow(global_position.x - targetPosition.x,2) + pow(global_position.y - targetPosition.y, 2)))

func getDistanceToPositionOnOrbit() -> float:
	return float(sqrt(pow(global_position.x - getPositionOnOrbit().x,2) + pow(global_position.y - getPositionOnOrbit().x,2)))

func changeForm():
	ballForm = !ballForm
	icecleForm = !icecleForm
	if icecleForm:
		setCollision("3","4")
	else:
		setCollision("","")

func setCollision(layersList : String, masksList : String):
	for i in range(1,9):
		hitbox.set_collision_layer_value(i, char(i) in layersList)
		hitbox.set_collision_mask_value(i, char(i) in masksList)

func flyOnOrbit(): # (TODO) REMOVE
	if readyToFly:
		global_position = getPositionOnOrbit()
		return
	var timeToFlyToTarget = getDistanceToTarget() / speed
	var timeToFlyToOrbitPosition = getDistanceToPositionOnOrbit() / speed
	# print("orbit: ", timeToFlyToOrbitPosition, "\ntarget: ", timeToFlyToTarget)
	if timeToFlyToOrbitPosition < 5 or timeToFlyToTarget < 2:
		global_position = getPositionOnOrbit()
		readyToFly = true
	else:
		if timeToFlyToTarget > 50:
			global_position += (targetPosition - global_position).normalized() * speed * 3
		else:
			global_position += (getPositionOnOrbit() - global_position).normalized() * speed

func getPositionOnOrbit() -> Vector2:
	return Vector2(
				sin(p * speed * orbitSpeedMult) * radius,
				cos(p * speed * orbitSpeedMult) * radius
				) + targetPosition

func _on_fly_timer_timeout() -> void:
	changeForm()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	if icecleForm:
		print("Hit")
		flyTimer.stop()
		changeForm()
