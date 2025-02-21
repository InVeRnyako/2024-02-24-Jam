extends CharacterBody2D

@export_category("Player values")
@export var Health : int = 5
@export var BallsCount : int = 3
@export var BaseSpeed : int = 400
@export var BaseAcceleration : int = 1500
@export var BaseFriction : int = 600
@export_category("Balls values")
@export var BallScale : float = 0.2
@export var BallRotationSpeed : float = -5

@export_category("Ball Parameters")
@export var ballSpeed : float = 5
@export var orbitRadius : float = 50
@export var orbitSpeedMult : float = 5
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
# @export var ball : CharacterBody2D

var input = Vector2.ZERO
var BallScene = "res://Scenes/ball.tscn"
var Speed : int
var Acceleration : int
var Friction : int
var BallsArray = []
var BallsPosition = 0

func _ready() -> void:
	speedUpdate()
	brain.init(self)
	createBalls()
		# BallsArray[i].set_player(self)
	# animation.play()

func recountOrbitOffset():
	if BallsArray.size() > 0:
		var offsetCount = 0
		var offsetMultiplier = 2 * PI / BallsCount
		for i in BallsArray.size():
			BallsArray[i].orbitOffset = offsetCount * offsetMultiplier
			offsetCount += 1

func createSingleBall():
	var newBall = load(BallScene).instantiate()
	# add_child(newBall)
	BallsArray.append(newBall)

func createBalls():
	for i in range(BallsArray.size(),BallsCount):
		createSingleBall()
		BallsArray[i].Arrayid = i
	for ball in BallsArray:
		if ball is Ball: # child not in BallsArray and
			add_child(ball)
			ball.init(self)
		else:
			print("ERROR! ", ball.get_instance_id(), "is not ball but in ball array")
	for child in get_children():
		if child is Ball and child not in BallsArray:
			remove_child(child)
	recountOrbitOffset()

func speedUpdate():
	Speed = int(float(BaseSpeed) * ModSpeed)
	Acceleration = int(float(BaseAcceleration) * ModAccel)
	Friction = int(float(BaseFriction) * ModFriction)
	
func _physics_process(delta: float) -> void:
	countOrbitPosition()
	get_input()
	brain._process(delta)

func countOrbitPosition():
	BallsPosition += BallRotationSpeed / 100
	if BallsPosition > 360:
		BallsPosition -= 360
	else: if BallsPosition < 0:
		BallsPosition += 360

func get_input():
	if (int(Input.is_action_pressed("ui_right")) - int (Input.is_action_pressed("ui_left"))) != 0 or \
		(int(Input.is_action_pressed("ui_down")) - int (Input.is_action_pressed("ui_up"))) != 0:
		trying_to_walk = true
	else:
		trying_to_walk = false
	trying_to_attack = Input.is_action_just_pressed("Attack")

func ballAttack() -> bool:
	var ballId : int = findFreeBall()
	if ballId == -1:
		print("all balls busy")
		return false
	else:
		BallsArray[ballId].actionCommand()
		return true
	

func findFreeBall() -> int:
	for i in BallsArray.size():
		if BallsArray[i].readyForAction:
			return i
	return -1
	
func getOrbitPosition() -> float:
	return BallsPosition
