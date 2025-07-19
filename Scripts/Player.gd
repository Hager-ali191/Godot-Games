extends KinematicBody2D

onready var ray = $RayCast2D

var inputs = {
	
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT,

}

func _process(delta):
	$AnimationPlayer.play("Idle")
	pass

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
		if event.is_action_pressed("restrart"):
			get_tree().reload_current_scene()
	pass
	
func move(dir):
	var vector_pos = inputs[dir] * 16
	ray.cast_to = vector_pos
	ray.force_raycast_update()
	$Tween.interpolate_property(
		self , "position" , position ,
		position + vector_pos , 0.1 ,
		Tween.TRANS_SINE , Tween.EASE_IN
	)
	if !ray.is_colliding():
		$Tween.start()
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("box"):
			if collider.move(dir):
				position += vector_pos
