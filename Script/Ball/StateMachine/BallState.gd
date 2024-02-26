class_name BallState
extends Node

var playerPosition : Vector2
var puppet : CharacterBody2D
var sprite : Sprite2D
var layersList : String = ""
var masksList : String = ""
var brain : Node

func init():
	for child in get_children():
		if child is Sprite2D:
			sprite = child
			break
	setLayersAndMasks()

func enter():
	pass

func changeSpriteAndCollision():
	puppet.changeSprite(sprite)
	puppet.setCollision(layersList, masksList)

func exit():
	pass

func setLayersAndMasks():
	pass

func action():
	pass

func areaEntered(_area):
	pass
