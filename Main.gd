extends Node

#Variáveis 
var timer = 1 #Timer para o funcionamento dos anos no jogo 
var aux = 0 #Variável auxiliar 
var cont = 11 #Variável contador
var eventos = [0,1,2,3] #Vetor para a separação de cada evento ao decorrer do tempo
var auxrandom = 0 #Número randomico para a escolha de um dos eventos

#Função new_games
func new_game():
	#Mostrar na tela todos os botões após o início do jogo 
	$Populacao/Button/AnimatedSprite.show()
	$Populacao/Button/Label.show()
	$Populacao/Button.show()
	$Recursos/Button/AnimatedSprite.show()
	$Recursos/Button/Label.show()
	$Recursos/Button.show()
	$Upgrades/Button/AnimatedSprite.show()
	$Upgrades/Button/Label.show()
	$Upgrades/Button.show()
	$HUD/Label.text = "0" #Início do ano como 0 
	$Timer.start() #Start do tempo 

#Sinal para a contagem do tempo 
func _on_Timer_timeout():
	$HUD/Label.text = str(timer) #Atualização da label do tempo do deccorer do jogo 
	timer += 1 #Atualização do tempo 
	if timer == cont: #Comparativo para saber se ja passaram 10 anos
		print("Passaram 10 anos") 
		_randomize_my_variable(auxrandom) #Chamada da função randomize_my_variable
		cont += 10 #Contador aumenta para mantes de 10 em 10 anos 

#Sinal para o start do jogo 
func _on_HUD_hit():
	new_game() #Chamada do new_game

 
"""func _on_HUD_map():
	aux += 1
	$HUD/Label.hide()
	if aux == 2:
		$HUD/Label.show()
		aux = 0"""

#Função para randomizar uma variável 
func _randomize_my_variable(variavel): 
	variavel = randi()%4  #Escolha do número random 
	evento(variavel) #Chamada da função evento 

#Função evento 
func evento(rand):
	#Dependendo do número de entrada será escolhido um dos eventos para a dinânimca e lógica do jogo 
	if rand == 1: 
		print("1")
	elif rand == 2:
		print("2")
	elif rand == 3:
		print("3")
	elif rand == 0:
		print("0")