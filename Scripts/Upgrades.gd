extends Node2D

#Variáveis usadas
var cont  = 0 #Contador aux
onready var TweenNode = get_node("Tween")

#Variáveis do Castelo
var nivelC = 1 #Nível do castelo
var quantidadeMadeira = 0 #Quantidade de madeira necessária para passar o nível do castelo
var quantidadeMetal = 0 #Quantidade de metal necessária para passar o nível do castelo
var quantidadePopulacao = 20 #Quantidade que aumentará na população total 
signal castelo #Sinal para receber a quantidade de recursos que o jogador possui

#Variavel teste
var gostodebolo = 0

#Função ready
func _ready():
	set_process_input(true) 
	$nivel.hide()
	$upgradeButton/AnimatedSprite.hide() #Esconder da sprite do botão 
	$upgradeButton/Label.hide() #Esconder do texto do botão 
	$AnimatedSprite.hide() #Esconder a sprite da aba 
	$upgradeButton.hide() #Esconder o botão
	
func _input(event):
	if Input.is_action_just_pressed("ui_2"):#Se user aperta tecla W
    _on_Button_pressed()


#Sinal de botão 
func _on_Button_pressed():
	$AnimatedSprite.show() #Mostrar a aba quando pressionado 
	$nivel.show()
	TweenNode.interpolate_method(self, "movimento", 630, 310, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()
	cont += 1
	if cont == 2:
		#$AnimatedSprite.hide() #Esconder caso o botão seja pressionado novamente
		TweenNode.interpolate_method(self, "movimento", 310, 630, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
		cont = 0 #Reset do contador
		
func movimento(value):
	$AnimatedSprite.position.y = value
	$nivel.rect_position.y = value	

#Função para saber se houve upgrade no castelo
func castelo(madeira , metal , populacaoTotal):
	if quantidadeMadeira <= madeira and quantidadeMetal <= metal: #Caso os recursos q o jogador possui sejam maiores ou iguais o requisito 
		nivelC += 1 #Aumenta o nível do castelo em 1
		quantidadeMadeira += 100 #Aumenta a quantidade de madeira necessária para o próximo nível
		quantidadeMetal += 100 #Aumenta a quantidade de metal necessário para o próximo nível
		quantidadePopulacao += quantidadePopulacao #Aumenta a população que fica viva  
		return quantidadePopulacao #Retorna a quantidade de população atual após o upgrade

#Função para saber se o botão de upgrade foi pressionado
func _on_nivel_pressed():
	emit_signal("castelo") #Emite um sinal para receber informações de outros nós

