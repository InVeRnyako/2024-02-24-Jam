extends State

var MaxSpeed : int 
var Acceleration : int 
var Friction : int 
var input : Vector2 = Vector2.ZERO

func enter():
	puppet.animation.play("Walk")
	MaxSpeed = puppet.Speed
	Acceleration = puppet.Acceleration
	Friction = puppet.Friction
	puppet.velocity = Vector2.ZERO

func action():
	input = get_input()
	puppet.speedUpdate()
	if input == Vector2.ZERO:
		if puppet.velocity.length() > (Friction):
			puppet.velocity -= puppet.velocity.normalized() * (Friction)
		else:
			puppet.velocity = Vector2.ZERO
	else:
		if input.x < 0:
			puppet.animation.flip_h = true
		else: 
			if input.x > 0:
				puppet.animation.flip_h = false
		puppet.velocity += (input * Acceleration)
		puppet.velocity = puppet.velocity.limit_length(MaxSpeed)
	
	puppet.move_and_slide()

func get_input() -> Vector2:
	input.x = int(Input.is_action_pressed("ui_right")) - int (Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
