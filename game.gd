extends Node2D

@onready var pause_menu = %PauseMenu
var pause = false

func spawn():
	var new_mob = preload("res://mob.tscn").instantiate()
	%spawner_follow.progress_ratio = randf()
	new_mob.global_position = %spawner_follow.global_position
	add_child(new_mob)
func _on_timer_timeout() -> void:
	spawn()
func _on_player_health_finish() -> void:
	get_tree().change_scene_to_file("res://game_over.tscn")

func health_spawn():
	var new_hp = preload("res://scenes/health.tscn").instantiate()
	%health_spawner_follow.progress_ratio = randf()
	new_hp.global_position = %health_spawner_follow.global_position
	add_child(new_hp)

func _on_health_spawner_timer_timeout() -> void:
	health_spawn()
	%HealthNotice.visible = true
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if pause:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	pause = !pause
