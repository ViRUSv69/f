extends CharacterBody2D

signal health_finish
var Player_Health = 100.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0:
		get_node("HappyBoo").play_walk_animation()
	else:
		get_node("HappyBoo").play_idle_animation()	
		
	if %AttackBar.value != %AttackBar.max_value:
		%AttackBar.value = %AttackTimer.wait_time - %AttackTimer.time_left
	
	if Input.is_action_just_pressed("attack") and %AttackBar.value == %AttackBar.max_value:
		%AttackBar.value =0
		%AttackTimer.start()
		%AttackNotice.visible = false
		var mobs_in_killzone = %Killzone.get_overlapping_bodies()
		for mob in mobs_in_killzone:
			if mob is Enemy:
				mob.kill()
	
	var DAMAGE_RATE = 5
	var overlapping_mobs = %Hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		Player_Health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%PlayerHealthBar.value = Player_Health
		if Player_Health <= 0:
			health_finish.emit() 
	


func _on_timer_timeout() -> void:
	%AttackBar.value = %AttackBar.max_value
	%AttackNotice.visible = true
	
