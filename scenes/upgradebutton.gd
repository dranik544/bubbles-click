extends Button

@export var isSkipButton: bool = false
enum upgrade {addMoreBubbles, addMoreScoreFromBubble, disableSomeToxicBubbles}
@export var currentUpgrade: upgrade
@export var chanceBeDeleted: int = 2
@export var upgradeSelectNode: Control


func _ready() -> void:
	pressed.connect(
		func():
			upgradeSelectNode.hide()
			get_tree().paused = false
			if isSkipButton: return
			
			match currentUpgrade:
				upgrade.addMoreBubbles:
					Global.addChanceSpawnMultiplier *= 1.2
				upgrade.addMoreScoreFromBubble:
					Global.addScoreMultiplier *= 1.2
				upgrade.disableSomeToxicBubbles:
					Global.chanceSpawnToxicBubble += 1
	)
	
	Global.updatelevel.connect(updatelevel)

func updatelevel():
	var random: int = randf_range(0, chanceBeDeleted)
	if !isSkipButton and random != 0:
		hide()
	else:
		show()
