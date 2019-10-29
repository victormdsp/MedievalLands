extends CanvasLayer

#Variáveis usadas para a funcionalidade da HUD
var cont = [0,0,0,0] #Vetor para saber qual dos botões foram pressionados
signal hit #Sinal de hit para funcionalidades do mapa e início do jogo
signal map #Sinal para quando o mapa for pressionado , ser o principal HUD a aparecer na tela deixando os demais escondidos 

#Função ready(Início do programa) 
func _ready():
	#Após o início do programa , esconder todos os botões da tela
	$Time.hide()
	$comida.hide()
	$metal.hide()
	$madeira.hide()

#Função new_game para o start do jogo 
func new_game():
	#Ao iniciar mostrar todos os menus e botões do jogo 
	
	$StartButton.hide() #Esconde o botão de start game
	emit_signal("hit") #Emite um sinal para a classe main 



