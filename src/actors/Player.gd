extends KinematicBody2D

export (int)  var speed = 200
export (float) var next_time_to_fire = 0.25
export (PackedScene) var bullet

var velocity = Vector2.ZERO
var waiting_to_fire = 0

func _ready():
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	
func _physics_process(delta):
	get_input()
	
	waiting_to_fire -= delta
	if Input.is_action_pressed("shoot") and waiting_to_fire <= 0.0:
		shoot()
	move_and_slide(velocity * speed)

func get_input():
	#Set movement by getting input strength
	velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
		
	#Make player look toward mouse cursor
	var look_pos = get_global_mouse_position() - global_position
	global_rotation = atan2(look_pos.y, look_pos.x)
	
func shoot():
	var b = bullet.instance()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	waiting_to_fire = next_time_to_fire
