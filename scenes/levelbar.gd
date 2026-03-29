extends ProgressBar

@export var label: Label


func _ready() -> void:
	Global.updatescorelevel.connect(updatescorelevel)
	Global.updatelevel.connect(updatelevel)
	
	updatelevel()
	updatescorelevel()

func updatelevel():
	label.text = str(Global.currentLevel) + " LVL"
	max_value = Global.neededScoreLevel

func updatescorelevel():
	value = Global.currentScorelevel
