extends Node2D

#Variáveis auxiliares
var cont  = 0 #Contador auxiliar
var aux = 0 #Variável auxiliar 

#Variáveis para a animação 
onready var TweenNode = get_node("Tween")

#Variáveis para os recursos necessários 
var madeiraN = 100   
var metalN = 100
var dinheiroN = 100 
var alimentoN = 100 

#Variáveis para os recursos iniciais 
var madeira = 5000 #Quantidade de madeira
var metal = 5000 #Quantidade de metal
var alimento = 100 #Quantidade de alimenro
signal madeira #Sinal para saber se o jogador quer pegar mais madeira
signal metal #Sinal para saber se o jogador quer pegar mais metal
signal comida #Sinal para saber se o jogador quer pegar mais comida

#Função ready 
func _ready():
	set_process_input(true)
	$PegarC.hide() #Esconde o botão de pegar comida até ser chamado  
	$PegarM.hide() #Esconde o botão de pegar metal até ser chamado
	$PegarR.hide() #Esconde o botão de pegar madeira até ser chamado
	$Button/AnimatedSprite.hide() #Esconder da sprite do botão 
	$Button/Label.hide() #Esconder do texto do botão 
	$AnimatedSprite.hide() #Esconder a sprite da aba 
	$Button.hide() #Esconder o botão
	$mensagem.hide() #Esconde a mensagem 
	
func _input(event):
	if Input.is_action_just_pressed("ui_3"):#Se user aperta tecla E
		_on_Button_pressed()

#Sinal de botão 
func _on_Button_pressed():
	if aux == 0:
		$AnimatedSprite.hide()
	else:
		$AnimatedSprite.show() #Mostrar a aba quando pressionado
		$PegarC.show() 
		$PegarM.show()
		$PegarR.show()
		TweenNode.interpolate_method(self, "movimento", 400, 80, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
		TweenNode.start()
		cont += 1
	if cont == 2:
		#$AnimatedSprite.hide() #Esconder caso o botão seja pressionado novamente
		TweenNode.interpolate_method(self, "movimento", 80, 400, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
		cont = 0 #Reset do contador
		
func movimento(value):
	$AnimatedSprite.position.y = value
	$PegarC.rect_position.y = value - 25
	$PegarM.rect_position.y = value + 50
	$PegarR.rect_position.y = value + 125
	$mensagem.rect_position.y = value + 75
	
func pegarmadeira(trabalhadores,dinheiroAtual, dinheiroN):
	if trabalhadores <= 0 or dinheiroAtual <= dinheiroN:
		faltaderecursos()
		return dinheiroAtual
			
	else:	
		print(dinheiroAtual)
		madeira = madeira + (trabalhadores % 5)
		print("MAD: ", madeira)
		dinheiroAtual = dinheiroAtual - dinheiroN
		return dinheiroAtual

func pegarmetal(trabalhadores, dinheiroAtual, dinheiroN):
	if trabalhadores <= 0 or dinheiroAtual <= dinheiroN:
		faltaderecursos()
		return dinheiroAtual
			
	else:
		print(dinheiroAtual)	
		metal = metal + (trabalhadores % 5)
		print("M: ", metal)
		dinheiroAtual = dinheiroAtual - dinheiroN
		return dinheiroAtual
		
func pegaralimento(trabalhadores, dinheiroAtual,dinheiroN):
	if trabalhadores <= 0 or dinheiroAtual <= dinheiroN:
		faltaderecursos()
		return dinheiroAtual
			
	else:
		print(dinheiroAtual)
		alimento = alimento + (5/100 * alimento)
		print("ALI: ", alimento)
		dinheiroAtual = dinheiroAtual - dinheiroN
		return dinheiroAtual - dinheiroN
		
func _on_PegarR_pressed():
	emit_signal("madeira")
	
func _on_PegarM_pressed():
	emit_signal("metal")

func _on_PegarC_pressed():
	emit_signal("comida")

func faltaderecursos():
	$mensagem.show()
	$mensagem.text = "Voce nao possui recursos suficiente"
	yield(get_tree().create_timer(1), "timeout")
	$mensagem.hide()