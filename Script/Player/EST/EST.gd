extends Node

var puppet : CharacterBody2D
var states : Dictionary = {}

var state_locked : bool = false
var current_state_name : String = "Idle"
var next_state_name : String = "Idle"

func init(link_to_puppet : CharacterBody2D) -> void:
	puppet = link_to_puppet
	for child in get_children():
		if child is State:
			states[child.name] = child
			states[child.name].puppet = puppet
			states[child.name].brain = self

func _process(_delta: float) -> void:
	next_state_name = action_choice()
	if next_state_name == "" or current_state_name == next_state_name:
		states[current_state_name].action()
	else:
		states[current_state_name].exit()
		current_state_name = next_state_name
		states[next_state_name].enter()

func action_choice() -> String:
	if puppet.Health < 1:
		return "Death"
	if state_locked:
		return ""
	if puppet.trying_to_attack:
		return "AttackRanged" # (TODO) Default maybe change later
	if puppet.trying_to_walk:
		return "Walk"
	return "Idle"
