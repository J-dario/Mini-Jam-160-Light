extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_how_pressed():
	get_tree().change_scene_to_file("res://scenes/how.tscn")
