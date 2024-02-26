extends BallState

var flyingDirection : int = 1
var speed : float
@onready var flyTimer : Timer = $FlyTimer

func enter():
	changeSpriteAndCollision()
	speed = puppet.ballSpeed
	startFlying()

func startFlying():
	if puppet.player.animation.flip_h:
		puppet.BallSprite.flip_h = true
		flyingDirection = -1
	else:
		puppet.BallSprite.flip_h = false
		flyingDirection = 1
	puppet.global_position.x = puppet.playerPosition.x + puppet.orbitRadius * flyingDirection
	puppet.global_position.y = puppet.playerPosition.y
	flyTimer.start()
	puppet.changeReadyForAction()

func action():
	if flyTimer.is_stopped():
		brain.defaultState()
	else:
		flyForward()

func flyForward():
	puppet.global_position.x += speed * flyingDirection

func setLayersAndMasks():
	layersList = "4"
	masksList = "8"

func areaEntered(area : Area2D):
	if str(area.collision_layer) in masksList:
		flyTimer.stop()
