extends CharacterBody2D

@export_category("Player values")
@export var Health : int = 5
@export var Balls : int = 1
@export var BaseSpeed : int = 400
@export var BaseAcceleration : int = 1500
@export var BaseFriction : int = 600

# "Player_intentions"
# var trying_to_hit : bool = false
# var trying_to_run : bool = false
@export_category("Player_intentions")
@export var trying_to_walk : bool = false
@export var trying_to_attack : bool = false

@export_category("Player surroundings")
@export var ModSpeed : float = 1.0
@export var ModAccel : float = 1.0
@export var ModFriction : float = 1.0
# EST links
@export_category("EST Links")
@export var brain : Node
@export var animation : AnimatedSprite2D
@export var ball : CharacterBody2D

var input = Vector2.ZERO
var Speed : int
var Acceleration : int
var Friction : int

func _ready() -> void:
	speedUpdate()
	brain.init(self)
	ball.set_player(self)
	# animation.play()

func speedUpdate():
	Speed = int(float(BaseSpeed) * ModSpeed)
	Acceleration = int(float(BaseAcceleration) * ModAccel)
	Friction = int(float(BaseFriction) * ModFriction)
	

func _physics_process(delta: float) -> void:
	get_input()
	brain._process(delta)
	ball.targetPosition = position

func get_input():
	if (int(Input.is_action_pressed("ui_right")) - int (Input.is_action_pressed("ui_left"))) != 0 or \
		(int(Input.is_action_pressed("ui_down")) - int (Input.is_action_pressed("ui_up"))) != 0:
		trying_to_walk = true
	else:
		trying_to_walk = false
	trying_to_attack = Input.is_action_pressed("Attack")

func ballAttack() -> bool:
	if ball.readyToFly:
		ball.startFlying()
		return true
	else:
		return false
