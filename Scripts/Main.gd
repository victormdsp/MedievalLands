extends Node

#Variáveis auxiliares
var aux = 0 #Variável auxiliar 
var cont = 11 #Variável contador 
var botao = 0 #Variável informações 
var dinheiro = 0 #Guarda a quantidade de dinheiro atual 

#Variáveis dos Eventos
var event = 4 #Variável de escolha de eventos
var auxpop = 0 #Auxiliar que armazena o cálculo da quantidade de pessoas que nasceram ou morreram
var armazemPop = 0 #Variável que armazena o valor da quantidade de gente que nasceu 
var armazemEvent = 0 #Variável que escolhe entre um dos eventos 

#Variáveis do tempo
var auxtempo = 0
var timer = 1 #Timer para o funcionamento dos anos no jogo 

#Variáveis da população 
var pessoasvivas = 0

func _ready():
	$HUD/Label.hide() #Esconde o texto da mensagem 
	$Button.hide() #Esconde o botão da informação
	$Timer/SpeedTime.hide() #Esconde o botão de acelerar o jogo 

#Função new_games
func new_game():
	#Mostrar na tela todos os botões após o início do jogo 
	$Populacao/Button/AnimatedSprite.show()
	$Populacao/Button/Label.show()
	$Populacao/Button.show()
	$Populacao/PopulacaoLabel.text = str("Population: ",$Populacao.quantidade)
	$Recursos/Button/AnimatedSprite.show()
	$Recursos/Button/Label.show()
	$Recursos/Button.show()
	$Upgrades/upgradeButton/AnimatedSprite.show()
	$Upgrades/upgradeButton/Label.show()
	$Upgrades/upgradeButton.show()
	$HUD/Time.show()
	$HUD/Label.show()
	$HUD/Label.text = "0" #Início do ano como 0 
	$Timer.start() #Start do tempo 
	$Button.show()
	$Timer/SpeedTime.show()

#Sinal para a contagem do tempo 
func _on_Timer_timeout():
	$HUD/Label.text = str(timer) #Atualização da label do tempo do deccorer do jogo 
	timer += 1 #Atualização do tempo 
	if timer == cont: #Comparativo para saber se ja passaram 10 anos
		dinheiro = $Populacao.imposto()
		armazemPop = $Populacao.nascer() #Chamda da função nascer e armazena na variável aux2
		armazemEvent = evento(_randomize_my_variable(event),armazemPop) #Chamda da função evento juntamente com a função de randomizar uma variável
		auxpop = populacao(armazemPop,armazemEvent) #Chamada da função para atualizar população
		$Populacao/PopulacaoLabel.text =  str("Population: ",$Populacao.quantidade) 
		cont += 10 #Contador aumenta para mantes de 10 em 10 anos
			
#Sinal para o start do jogo 
func _on_HUD_hit():
	new_game() #Chamada do new_game

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

#Função População
func populacao(resul1,resul2):
	var total = resul1 + resul2
	$Populacao.quantidade += resul1 + resul2 #Cálculo da quantidade da população baseado nos eventos  
	#print("População: ",$Populacao.quantidade,"\n") 
	return total 

#Função printinfo para printar as informçãoes do jogo a cada tempo que passar
func printinfo(cont):
	$Informacoes/AnimatedSprite.show()
	$Informacoes/Label3.show()
	$Informacoes/Label3.text = str("Passaram-se: ",timer," anos")
	$Informacoes/Label4.show()
	$Informacoes/Label5.show()
	
	if cont > 0:
		$Informacoes/Label4.text = str("A populacao cresceu em: ", cont)
		
	elif cont < 0:
		$Informacoes/Label4.text = str("A populacao diminuiu em: ", cont)
	
	else:
		$Informacoes/Label4.text = "A populacao se manteve"	
	
	return cont 

#Função para se o botão das informações for pressionado 
func _on_Button_pressed():
	printinfo(auxpop)
	botao += 1
	
	if botao == 2:
		$Informacoes/AnimatedSprite.hide()
		$Informacoes/Label3.hide()
		$Informacoes/Label4.hide()
		$Informacoes/Label5.hide()
		botao = 0 

#Função para deixar o jogo mais rapido 
func _on_SpeedTime_pressed():
	$Timer.wait_time -= 0.4 #Diminui o tempo de espera entre o passar dos anos 
	auxtempo += 1 #auxiliar para saber se foi clicado 
	
	if auxtempo == 1: #Caso o auxiliar seja clicado trocar a sprite
		$Timer/SpeedTime/AnimatedSprite.animation = "tempo_2"
		
	elif auxtempo == 2: #Caso o auxiliar seja clicado novamente trocar a sprite
		$Timer/SpeedTime/AnimatedSprite.animation = "tempo_3"
	
	else: #Caso o auxiliar seja clicado mais uma vez ele reseta a sprite
		auxtempo = 0
		$Timer/SpeedTime/AnimatedSprite.animation = "tempo_1"
		$Timer.wait_time = 1 #Reseta a velocidade do tempo para 1 

#Funções para a chamada da busca de recursos
#Função que chama a função do cálculo para pegar comida  
func _on_Recursos_comida():
	$Recursos.pegaralimento($Populacao.quantidadeT,dinheiro)
	
#Função que chama a função do cálculo para pegar madeira 
func _on_Recursos_madeira():
	$Recursos.pegarmadeira($Populacao.quantidadeT,dinheiro)
	
#Função que chama a função do cálculo para pegar madeira
func _on_Recursos_metal():
	$Recursos.pegarmetal($Populacao.quantidadeT,dinheiro)

#Funções de upgrade
func _on_Upgrades_castelo():
	pessoasvivas = $Upgrades.castelo($Recursos.madeira ,$Recursos.madeiraN ,$Recursos.metal ,$Recursos.metalN ,$Recursos.dinheiro, $Recursos.dinheiroN)   
