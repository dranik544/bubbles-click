extends Node

# этот скрипт написан ИИ, я ничего в яндексSDK не соображаю

signal game_initialized
signal game_ready_called

var is_game_initialized = false

# --------------------------------------------
# Инициализация (вызвать первой в меню)
# --------------------------------------------
func init_game() -> void:
	if not OS.has_feature("web"):
		return
	if is_game_initialized:
		return
	
	# Просто вызываем InitGame, результат не ждём
	JavaScriptBridge.eval("""
		if (typeof InitGame !== 'undefined') {
			InitGame({}, function(env) {
				window.yandexInitialized = true;
			});
		}
	""")
	
	# Ждём флага (максимум 5 секунд)
	var t = 0.0
	while t < 5.0:
		var ready = JavaScriptBridge.eval("return window.yandexInitialized === true;")
		if ready:
			is_game_initialized = true
			game_initialized.emit()
			return
		await get_tree().create_timer(0.1).timeout
		t += 0.1
	print("YandexFunc: таймаут инициализации")

# --------------------------------------------
# Game Ready (работает как у вас)
# --------------------------------------------
func game_ready() -> void:
	JavaScriptBridge.eval("if (typeof GameReady !== 'undefined') GameReady(); else console.warn('GameReady not found');")
	game_ready_called.emit()

# --------------------------------------------
# Обычная реклама (блокирующая)
# --------------------------------------------
func show_interstitial_ad() -> void:
	JavaScriptBridge.eval("""
		if (typeof ShowAd !== 'undefined') {
			window._adFinished = false;
			ShowAd(function() { window._adFinished = true; });
		} else {
			window._adFinished = true;
		}
	""")
	while not JavaScriptBridge.eval("return window._adFinished === true;"):
		await get_tree().process_frame

# --------------------------------------------
# Реклама за награду (возвращает true если награда выдана)
# --------------------------------------------
func show_rewarded_ad() -> bool:
	JavaScriptBridge.eval("""
		if (typeof ShowAdRewardedVideo !== 'undefined') {
			window._rewardFinished = false;
			window._rewardGranted = false;
			ShowAdRewardedVideo(function(result) {
				window._rewardGranted = (result === 'rewarded');
				window._rewardFinished = true;
			});
		} else {
			window._rewardFinished = true;
			window._rewardGranted = false;
		}
	""")
	while not JavaScriptBridge.eval("return window._rewardFinished === true;"):
		await get_tree().process_frame
	var granted = JavaScriptBridge.eval("return window._rewardGranted === true;")
	return granted
