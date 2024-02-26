extends Node

var puppet : CharacterBody2D
var states : Dictionary = {}

var actionCalled : bool
var readyForAction : bool
var defaultStateName : String 
var currentStateName : String 
var nextStateName : String 

func init(link_to_puppet : CharacterBody2D) -> void:
	actionCalled = false
	readyForAction = true
	defaultStateName = "SphereState"
	currentStateName = ""
	nextStateName = defaultStateName
	puppet = link_to_puppet
	for child in get_children():
		# print(child.name,"\n", child.get_class(), child is BallState)
		if child is BallState:
			states[child.name] = child
			states[child.name].puppet = puppet
			states[child.name].brain = self
			states[child.name].init()
	states[defaultStateName].enter()

func defaultState():
	nextStateName = defaultStateName
	changeState()

func _process(_delta: float) -> void:
	if currentStateName == "":
		nextStateName = defaultStateName
		changeState()
	else: 
		if readyForAction:
			states[currentStateName].action()

func action():
	nextStateName = "IcicleState"
	changeState()

func changeState():
	if currentStateName != "":
		states[currentStateName].exit()
	currentStateName = nextStateName
	states[currentStateName].enter()

func areaEntered(_area):
	states[currentStateName].areaEntered(_area)
