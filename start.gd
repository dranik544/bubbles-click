extends Node2D

@onready var button: Button = $CanvasLayer/VBoxContainer/Button
@onready var checkbutton: CheckButton = $CanvasLayer/VBoxContainer/CheckButton
@onready var vbox: VBoxContainer = $CanvasLayer/VBoxContainer
@onready var label: Label = $CanvasLayer/Label
@onready var checkbutton2: CheckButton = $CanvasLayer/VBoxContainer/CheckButton2


func _ready() -> void:
	if !Global.disableAllYandexServices:
		YandexFunc.init_game()
		for i in 5: await get_tree().process_frame
		YandexFunc.game_ready()
	
	get_node("CanvasLayer/TextureRect").texture = load("res://sprites/default/bg1.png")
	
	button.pressed.connect(buttonpressed)
	checkbutton.toggled.connect(checkbuttontoggled)
	checkbutton2.toggled.connect(checkbutton2toggled)

func buttonpressed():
	vbox.visible = false
	label.visible = true
	
	for i in 10: await get_tree().process_frame
	
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func checkbuttontoggled(toggled: bool):
	Global.enableAnimation = not toggled

func checkbutton2toggled(toggled: bool):
	Global.disableAutoPause = toggled
