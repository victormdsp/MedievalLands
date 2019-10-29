extends Node2D

#Variáveis para a quantidade de cada pessoa em sua profissão e o total
var quantidade = 0 #Quantidade da população total
var quantidadeT = 0 #Quantidade de trabalhadores 
var quantidadeE = 0 #Quantidade de soldados
var quantidadeA = 0 #Quantidade de agricultores 
 
#Variáveis auxiliares
var cont  = 0 #Contador aux
var aux = 0 #Variável Auxiliar

#Variáveis da animação
onready var TweenNode = get_node("Tween")

#Variáveis recurso 
var dinheiro = 0 

#Função ready
func _ready():
	set_process_input(true)
	$PopulacaoLabel.hide()
	$Button/AnimatedSprite.hide() #Esconder da sprite do botão 
	$Button/Label.hide() #Esconder do texto do botão 
	$AnimatedSprite.hide() #Esconder a sprite da aba 
	$Button.hide() #Esconder o botão
	quantidadeA = 10 #Quantidade de agricultores inicial
	quantidadeE = 10 #Quantidade de soldados inicial
	quantidadeT = 10 #Quantidade de trabalhadores inicial
	quantidade = quantidadeA + quantidadeE + quantidadeT #Quantidade inicial da população
	
func _input(event):
	if Input.is_action_just_pressed("ui_1"):#Se user aperta tecla Q
		_on_Button_pressed()
    
#Sinal de botão 
func _on_Button_pressed():
	if aux == 0:
		$AnimatedSprite.hide()
	else:
		$AnimatedSprite.show() #Mostrar a aba quando pressionado 
		$PopulacaoLabel.show()
		TweenNode.interpolate_method(self, "movimento", 50+502, 280, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
		TweenNode.start()
		cont += 1
		if cont == 2:
			#$AnimatedSprite.hide() #Esconder caso o botão seja pressionado novamente
			TweenNode.interpolate_method(self, "movimento", 280, 50+550, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
			cont = 0 #Reset do contador
		
func movimento(value):
	$AnimatedSprite.position.y = value + 12
	$PopulacaoLabel.rect_position.y = value

#Função nascer ( baseada no tempo , quantas pessoas nascem no jogo)		
func nascer():
	var popu = quantidade * 1/4 #Variável para randomizar uma quantidade de pessoas que nascem 
	return popu #Retorna a variável popu
	
func imposto():
	dinheiro = quantidade * 2 + dinheiro
	return dinheiro 