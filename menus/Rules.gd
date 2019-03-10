extends Node

func _on_EndButton_pressed():
	_on_AudioTimer_timeout()
	$EndAudioStreamPlayer.play()
	$AudioTimer.start()

func _on_PitButton_pressed():
	_on_AudioTimer_timeout()
	$PitAudioStreamPlayer.play()
	$AudioTimer.start()


func _on_ZombieButton_pressed():
	_on_AudioTimer_timeout()
	$ZombieAudioStreamPlayer.play()
	$AudioTimer.start()

func _on_AudioTimer_timeout():
	$EndAudioStreamPlayer.stop()
	$PitAudioStreamPlayer.stop()
	$ZombieAudioStreamPlayer.stop()
	$BumpAudioStreamPlayer.stop()
	$ZombieDeathAudioStreamPlayer.stop()
	$ShootAudioStreamPlayer.stop()

func _on_ShootButton_pressed():
	_on_AudioTimer_timeout()
	$ShootAudioStreamPlayer.play()
	$AudioTimer.start()

func _on_ZombieDeathButton_pressed():
	_on_AudioTimer_timeout()
	$ZombieDeathAudioStreamPlayer.play()
	$AudioTimer.start()


func _on_BumpButton_pressed():
	_on_AudioTimer_timeout()
	$BumpAudioStreamPlayer.play()
	$AudioTimer.start()
