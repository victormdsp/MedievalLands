extends Node

#Variáveis 
var timer = 1 #Timer para o funcionamento dos anos no jogo 
var aux = 0 #Variável auxiliar 
var armazem1 = 0
var armazem2 = 0
var cont = 11 #Variável contador
#var auxrandom = 0 #Número randomico para a escolha de um dos eventos
var event = 4 #Variável de escolha de eventos
var auxpop = 0
var botao = 0

func _ready():
	$HUD/Label.hide()
	$Button.hide()
	$Timer/SpeedTime.hide()

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
	$HUD/Time.show()
	$HUD/Label.show()
	$HUD/populacao.text = str("População: ",$Populacao.quantidade)
	$HUD/populacao.show()
	$HUD/Label.text = "0" #Início do ano como 0 
	$Timer.start() #Start do tempo 
	$Button.show()
	$Timer/SpeedTime.show()

#Sinal para a contagem do tempo 
func _on_Timer_timeout():
	$HUD/Label.text = str(timer) #Atualização da label do tempo do deccorer do jogo 
	timer += 1 #Atualização do tempo 
	if timer == cont: #Comparativo para saber se ja passaram 10 anos
		armazem2 = nascer() #Chamda da função nascer e armazena na variável aux2
		armazem1 = evento(_randomize_my_variable(event),armazem2) #Chamda da função evento juntamente com a função de randomizar uma variável
		auxpop = populacao(armazem1,armazem2) #Chamada da função para atualizar população
		$HUD/populacao.text =  str("População: ",$Populacao.quantidade) 
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
func _randomize_my_variable(teste):
	randomize()
	var variavel = randi()%teste  #Escolha do número random 
	return variavel #Retorna um número randomico 

#Função evento 
func evento(rand,popR):
	
	var resultado = 0
	#Dependendo do número de entrada será escolhido um dos eventos para a dinânimca e lógica do jogo 
	
	if rand == 1: 
		resultado += 7 + popR * 20/100
		$Informacoes/Label5.text = str("Houve uma boa colheita nascendo ", resultado, " a mais")
		return resultado
		
	elif rand == 2:
		resultado -= 10 + popR * 75/100
		$Informacoes/Label5.text = str("Houve uma guerra matando: ", resultado)
		return resultado
		
	elif rand == 3:
		resultado -= 5 + popR * 75/100
		$Informacoes/Label5.text = str("Houve uma doença matando: ", resultado)
		return resultado
		
	elif rand == 0:
		resultado -= 7 + popR * 75/100
		$Informacoes/Label5.text = str("Houve um inverno rigoroso matando: ", resultado)
		return resultado

#Função nascer ( baseada no tempo , quantas pessoas nascem no jogo)		
func nascer():
	var popu = randi()%$Populacao.quantidade / 2 #Variável para randomizar uma quantidade de pessoas que nascem 
	return popu #Retorna a variável popu
	
#Função População
func populacao(resul1,resul2):
	var total = resul1 + resul2
	$Populacao.quantidade += resul1 + resul2 #Cálculo da quantidade da população baseado nos eventos  
	#print("População: ",$Populacao.quantidade,"\n") 
	return total 
	
func printinfo(cont):
	$Informacoes/AnimatedSprite.show()
	$Informacoes/Label3.show()
	$Informacoes/Label3.text = str("Passaram-se: ",timer," anos")
	$Informacoes/Label4.show()
	$Informacoes/Label5.show()
	if cont > 0:
		$Informacoes/Label4.text = str("A população cresceu em: ", cont)
		
	elif cont < 0:
		$Informacoes/Label4.text = str("A população diminuiu em: ", cont)
	
	else:
		$Informacoes/Label4.text = "A população se manteve"	
	
	return cont 
	
		

func _on_Button_pressed():
	printinfo(auxpop)
	botao += 1
	if botao == 2:
		$Informacoes/AnimatedSprite.hide()
		$Informacoes/Label3.hide()
		$Informacoes/Label4.hide()
		$Informacoes/Label5.hide()
		botao = 0 
	


func _on_SpeedTime_pressed():
	if $Timer.wait_time <= 1.0:
		$Timer.wait_time -= 0.2
		print($Timer.wait_time)
	if $Timer.wait_time <= 0.1:
		$Timer.wait_time = 0.6
		print($Timer.wait_time)
	
	
	
