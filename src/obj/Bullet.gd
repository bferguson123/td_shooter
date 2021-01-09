extends Area2D

export (int) var speed = 1000
export (int) var damage = 10

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(area):
	area.hit(damage)
	queue_free()
