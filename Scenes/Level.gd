extends Node2D


var Game_end = false

func _process(delta):
	if Game_end == true:
		get_tree().paused = true
	check_end()
	pass

func check_end():
	if Game_end == false:
		var all_filled = true  # نفترض أن كل الصناديق في مكانها
		
		for spot in $Spots.get_children():
			if not spot.in_spot:  # إذا وجدنا إشارة واحدة فارغة
				all_filled = false
				break  # نخرج من الحلقة فوراً
				
		if all_filled:  # فقط إذا كانت كل الإشارات ممتلئة
			$AcceptDialog.popup()
			Game_end = true


func _on_AcceptDialog_confirmed():
	get_tree().reload_current_scene()
	get_tree().paused = false 

func _on_AcceptDialog_popup_hide():
	get_tree().reload_current_scene()
	get_tree().paused = false 
