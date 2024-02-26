class_name BallState
extends Node

var puppet : CharacterBody2D
var sprite : Sprite2D
var hitbox : Area2D
var layersList : String = ""
var masksList : String = ""
var readyForAction : bool = false

func _init():
	for child in get_children():
		if child is Sprite2D:
			sprite = child
			break
	setLayersAndMasks()

func enter():
	puppet.changeSprite(sprite)
	puppet.setCollision(layersList, masksList)

#func exit():
	#pass

func setLayersAndMasks():
	pass

func action():
	pass
