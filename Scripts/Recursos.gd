extends Node2D

#Variáveis usadas
var cont  = 0 #Contador auxiliar 
onready var TweenNode = get_node("Tween")

#Variáveis para os recursos iniciais 
var madeira = 50
var metal = 50 
var dinheiro = 100
var alimento = 100

#Função ready 
func _ready():
	set_process_input(true)
	$Button/AnimatedSprite.hide() #Esconder da sprite do botão 
	$Button/Label.hide() #Esconder do texto do botão 
	$AnimatedSprite.hide() #Esconder a sprite da aba 
	$Button.hide() #Esconder o botão
	$mensagem.hide()
	
func _input(event):
	if Input.is_action_just_pressed("ui_3"):#Se user aperta tecla E
		_on_Button_pressed()

#Sinal de botão 
func _on_Button_pressed():
	$AnimatedSprite.show() #Mostrar a aba quando pressionado 
	TweenNode.interpolate_method(self, "movimento", 400, 80, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()
	cont += 1
	if cont == 2:
		#$AnimatedSprite.hide() #Esconder caso o botão seja pressionado novamente
		TweenNode.interpolate_method(self, "movimento", 80, 400, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
		cont = 0 #Reset do contador
		
func movimento(value):
	$AnimatedSprite.position.y = value
	pass
	
func pegarmadeira(trabalhadores,dinheiroN):
	if trabalhadores <= 0:
		$PegarR/mensagem.show()
		$PegarR/mensagem.texte = "Você não possui trabalhadores suficiente"
		yield(get_tree().create_timer(1), "timeout")
		$PegarR/mensagem.hide()
		
	elif dinheiro <= dinheiroN:
		$PegarR/mensagem.show()
		$PegarR/mensagem.texte = "Você não possui dinheiro suficiente"
		yield(get_tree().create_timer(1), "timeout")
		$PegarR/mensagem.hide()
			
	else:	
		madeira = trabalhadores / 2
		dinheiro = dinheiro - dinheiroN
		$mensagem.show()
		$mensagem.texte = str("Você pegou " ,madeira," madeiras")
		yield(get_tree().create_timer(1), "timeout")
		$mensagem.hide()

func pegarmetal(trabalhadores,dinheiroN):
	if trabalhadores <= 0:
		$mensagem.show()
		$mensagem.texte = "Você não possui trabalhadores suficiente"
		yield(get_tree().create_timer(1), "timeout")
		$PegarR/mensagem.hide()
		
	elif dinheiro <= dinheiroN:
		$mensagem.show()
		$mensagem.texte = "Você não possui dinheiro suficiente"
		yield(get_tree().create_timer(1), "timeout")
		$PegarR/mensagem.hide()
			
	else:	
		metal = trabalhadores / 2
		dinheiro = dinheiro - dinheiroN
		$mensagem.show()
		$mensagem.texte = str("Você pegou " ,metal," metais")
		yield(get_tree().create_timer(1), "timeout")
		$mensagem.hide()
		
func pegaralimento(trabalhadores,dinheiroN):
	if trabalhadores <= 0:
		$mensagem.show()
		$mensagem.texte = "Você não possui trabalhadores suficiente"
		yield(get_tree().create_timer(1), "timeout")
		$PegarR/mensagem.hide()
		
	elif dinheiro <= dinheiroN:
		$mensagem.show()
		$mensagem.texte = "Você não possui dinheiro suficiente"
		yield(get_tree().create_timer(1), "timeout")
		$PegarR/mensagem.hide()
			
	else:	
		alimento = trabalhadores / 2
		dinheiro = dinheiro - dinheiroN
		$mensagem.show()
		$mensagem.texte = str("Você pegou " ,alimento," comidas")
		yield(get_tree().create_timer(1), "timeout")
		$mensagem.hide()