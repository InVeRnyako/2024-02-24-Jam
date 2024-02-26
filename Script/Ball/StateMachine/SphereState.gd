extends BallState

func setLayersAndMasks():
	layersList = ""
	masksList = ""

func action():
	if readyForAction:
		flyOnOrbit()
	
	
func flyOnOrbit():
	puppet.global_position = getPositionOnOrbit()
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
