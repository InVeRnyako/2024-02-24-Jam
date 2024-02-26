extends BallState


var distanceToTarget : float
var timeToFlyToTarget : float
var timeToFlyToOrbitPosition : float

var orbitPosition : float = 0

# imported vars:
var speed : float
var radius : float 
var orbitSpeedMult : float



func enter():
	changeSpriteAndCollision()
	speed = puppet.ballSpeed
	radius = puppet.orbitRadius
	orbitSpeedMult = puppet.orbitSpeedMult / 100

func setLayersAndMasks():
	layersList = ""
	masksList = ""

func trackOrbitPosition() -> float:
	return puppet.getOrbitPosition()
	#orbitPosition += orbitSpeedMult
	#if orbitPosition > 360:
		#orbitPosition -= 360
	#else: if orbitPosition < -360:
		#orbitPosition += 360


func action():
	orbitPosition = trackOrbitPosition()
	playerPosition = puppet.playerPosition
	if puppet.readyForAction:
		flyOnOrbit()
	else:
		timeToFlyToTarget = getTimeToGetToTarget()
		timeToFlyToOrbitPosition = getTimeToGetToPositionOnOrbit()
		if timeToFlyToOrbitPosition < 22 or timeToFlyToTarget < 15:
			print("TTF: ", timeToFlyToOrbitPosition,", ",  timeToFlyToTarget)
			puppet.global_position = getPositionOnOrbit()
			puppet.changeReadyForAction()
		else:
			if timeToFlyToTarget > 100:
				print("FAR TTF: ", timeToFlyToOrbitPosition,", ",  timeToFlyToTarget)
				puppet.global_position += (playerPosition - puppet.global_position).normalized() * speed * 3
			else:
				print("CLOSE TTF: ", timeToFlyToOrbitPosition,", ",  timeToFlyToTarget)
				puppet.global_position += (getPositionOnOrbit() - puppet.global_position).normalized() * speed

func flyOnOrbit(): 
	puppet.global_position = getPositionOnOrbit()

func getTimeToGetToTarget() -> float:
	return float(sqrt(
		pow(puppet.global_position.x - playerPosition.x, 2) +
		pow(puppet.global_position.y - playerPosition.y, 2)) / speed)

func getTimeToGetToPositionOnOrbit() -> float:
	return float(sqrt(pow(puppet.global_position.x - getPositionOnOrbit().x,2) + pow(puppet.global_position.y - getPositionOnOrbit().x,2))  / speed)

func getPositionOnOrbit() -> Vector2:
	return Vector2(
				sin(orbitPosition) * radius,
				cos(orbitPosition) * radius
				) + playerPosition

