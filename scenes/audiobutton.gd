extends Button

enum type {music, sound}
@export var currentType: type


func _ready() -> void:
	pressed.connect(
		func():
			match currentType:
				type.music:
					Global.enableMusic = not Global.enableMusic
					Global.updatemusic.emit()
					if Global.enableMusic:
						icon = load("res://sprites/musicicon1.png")
					else:
						icon = load("res://sprites/musicicon2.png")
				type.sound:
					Global.enableSound = not Global.enableSound
					Global.updatesound.emit()
					if Global.enableSound:
						icon = load("res://sprites/soundicon1.png")
					else:
						icon = load("res://sprites/soundicon2.png")
			
			print(Global.enableMusic)
			print(Global.enableSound)
			print("-  -  -")
	)
