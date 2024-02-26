class_name Ball
extends CharacterBody2D

var ballSpeed : float
var orbitRadius : float
var orbitSpeedMult : float

@onready var brain : Node = $StateMachine
@onready var hitbox : Area2D = $Hitbox
@onready var d := 0.0

# parameters for SM to read:
@onready var BallSprite : Sprite2D = $BallSprite
var playerPosition : Vector2
var player : CharacterBody2D
var orbitOffset : float
# parameters for SM to change:
var readyForAction : bool = true
var Arrayid : int

func changeReadyForAction():
	readyForAction = !readyForAction
	print(readyForAction)

func init(playerCalling : CharacterBody2D) -> void: 
	player = playerCalling
	ballSpeed = player.ballSpeed
	orbitRadius = player.orbitRadius
	orbitSpeedMult = player.orbitSpeedMult

func _ready():
	brain.init(self)

func set_player(playerToSet : CharacterBody2D):
	player = playerToSet

func _process(_delta: float) -> void:
	playerPosition = player.position
	brain._process(_delta)

func changeSprite(newSprite : Sprite2D):
	BallSprite.texture = newSprite.texture

func actionCommand():
	brain.action()

func getOrbitPosition() -> float:
	return player.getOrbitPosition() + orbitOffset




#func changeForm():
	#ballForm = !ballForm
	#icecleForm = !icecleForm
	#if icecleForm:
		#setCollision("3","4")
	#else:
		#setCollision("","")

func setCollision(layersList : String, masksList : String):
	for i in range(1,9):
		set_collision_layer_value(i, char(i) in layersList)
		set_collision_mask_value(i, char(i) in masksList)


func _on_area_2d_area_entered(_area: Area2D) -> void:
	brain.areaEntered(_area)
	print("signal! : " , _area.name)
