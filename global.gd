extends Node

var disableAllYandexServices: bool = true

var disableAutoPause: bool = true
var score: int = 0
var enableAnimation: bool = true
var enableSound: bool = true
var enableMusic: bool = true

var currentLevel: int = 0
var currentScorelevel: int = 0
var neededScoreLevel: int = 5
var currentUpgrades: Array = []

var addScoreMultiplier: float = 1.0
var addChanceSpawnMultiplier: float = 1.0
var chanceSpawnToxicBubble: float = 1.0
var chanceSpawnRareBubbles: float = 1.0

signal updatescore
signal updatemusic
signal updatesound
signal updatelevel
signal updatescorelevel


func addscore(addscore: int):
	score += int(addscore * addScoreMultiplier)
	currentScorelevel += int(abs(addscore * addScoreMultiplier))
	
	if currentScorelevel >= neededScoreLevel:
		currentLevel += 1
		currentScorelevel = 0
		neededScoreLevel *= 2.0
		
		updatelevel.emit()
	
	updatescore.emit()
	updatescorelevel.emit()
