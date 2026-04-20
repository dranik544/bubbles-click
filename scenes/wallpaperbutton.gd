extends Button

var allwallpapers: Array = [
	preload("res://sprites/default/bg1.png"),
	preload("res://sprites/default/bg2.png"),
	preload("res://sprites/default/bg3.png"),
	preload("res://sprites/default/bg4.png"),
	preload("res://sprites/default/bg5.png"),
	preload("res://sprites/default/bg6.png"),
	preload("res://sprites/default/bg7.png"),
	preload("res://sprites/default/bg8.png"),
	preload("res://sprites/default/bg9.png"),
	preload("res://sprites/default/bg10.png"),
	preload("res://sprites/default/bg11.png"),
	preload("res://sprites/default/bg12.png"),
	preload("res://sprites/default/bg13.png"),
]
var currentWallpaper: int = 0
@export var bg: TextureRect


func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if Global.disableAllYandexServices:
		change_wallpaper()
		return
	
	get_tree().paused = true
	var result = await YandexFunc.show_rewarded_ad()
	get_tree().paused = false
	
	if result: change_wallpaper()

func change_wallpaper():
	currentWallpaper += 1
	if currentWallpaper > allwallpapers.size() - 1 or currentWallpaper < 0:
		currentWallpaper = 0
	bg.texture = allwallpapers[currentWallpaper]
