extends Area2D

@export var DAMAGE = 0.5

func _physics_process(delta):
	var mobs_in_range= get_overlapping_bodies()
	if mobs_in_range.size() > 0:
		var target_mob = mobs_in_range.front()
		look_at(target_mob.global_position) 

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	%RifleShootPoint.add_child(new_bullet)
	new_bullet.global_position = %RifleShootPoint.global_position
	new_bullet.global_rotation = %RifleShootPoint.global_rotation


func _on_timer_timeout() -> void:
	shoot()
