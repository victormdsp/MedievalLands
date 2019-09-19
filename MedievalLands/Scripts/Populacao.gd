extends Node2D

#Variáveis usadas
var quantidade = 0 #Quantidade da população
var cont  = 0 #Contador aux
onready var TweenNode = get_node("Tween")
#Função ready
func _ready():
	set_process(true)
	$Button/AnimatedSprite.hide() #Esconder da sprite do botão 
	$Button/Label.hide() #Esconder do texto do botão 
	$AnimatedSprite.hide() #Esconder a sprite da aba 
	$Button.hide() #Esconder o botão
	quantidade = 20 #Quantidade inicial da população 

#Sinal de botão 
func _on_Button_pressed():
	$AnimatedSprite.show() #Mostrar a aba quando pressionado 
	TweenNode.interpolate_method(self, "movimento", 50+502, 280, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()
	cont += 1
	if cont == 2:
		#$AnimatedSprite.hide() #Esconder caso o botão seja pressionado novamente
		TweenNode.interpolate_method(self, "movimento", 280, 50+550, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
		cont = 0 #Reset do contador
		
func movimento(value):
	$AnimatedSprite.position.y = value
	pass
	