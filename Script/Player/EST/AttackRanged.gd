extends State

@onready var AttackTimer : Timer = $AttackTimer
@onready var AttackSFX : AudioStreamPlayer = $AttackSFX

func enter():
	puppet.animation.play("AttackRanged") # (TODO Polish) sync attack animation sound and call for ball

func action():
	shoot()

func shoot():
	if puppet.ballAttack():
		AttackSFX.play()
	else:
		pass

func exit():
	pass
