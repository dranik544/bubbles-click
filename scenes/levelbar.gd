extends ProgressBar

@export var label: Label
@export var label2: Label


func _ready() -> void:
	Global.updatescorelevel.connect(updatescorelevel)
	Global.updatelevel.connect(updatelevel)
	
	updatelevel()
	updatescorelevel()

func updatelevel():
	label.text = str(Global.currentLevel) + " Уровень"
	max_value = Global.neededScoreLevel

func updatescorelevel():
	value = Global.currentScorelevel
	label2.text = str(Global.currentScorelevel) + " / " + str(Global.neededScoreLevel)
