extends Node2D

#Variáveis usadas
var quantidade = 0 #Quantidade da população
var cont  = 0 #Contador aux

#Função ready
func _ready():
	$Button/AnimatedSprite.hide() #Esconder da sprite do botão 
	$Button/Label.hide() #Esconder do texto do botão 
	$AnimatedSprite.hide() #Esconder a sprite da aba 
	$Button.hide() #Esconder o botão
	quantidade = 20 #Quantidade inicial dda população 

#Sinal de botão 
func _on_Button_pressed():
	$AnimatedSprite.show() #Mostrar a aba quando pressionado 
	cont += 1
	if cont == 2:
		$AnimatedSprite.hide() #Esconder caso o botão seja pressionado novamente
		cont = 0 #Reset do contador