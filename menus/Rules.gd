extends Node

func _on_Button_pressed():
	$EndMusicAudioStreamPlayer.play()
	$EndMusicTimer.start()

func _on_Timer_timeout():
	$EndMusicAudioStreamPlayer.stop()
