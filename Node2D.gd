extends Node2D

var cont  = 0

func _ready():
	$Button/AnimatedSprite.hide()
	$Button/Label.hide()
	$AnimatedSprite.hide()
	$Button.hide()
	

func _on_Button_pressed():
	$AnimatedSprite.show()
	cont += 1
	if cont == 2:
		$AnimatedSprite.hide()
		cont = 0