extends bugMove


func _on_timer_timeout():
	random_generation()
	$Timer.start()
	
func damage():
	queue_free()
