extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	$CanvasLayer/BoxContainer/IntearctEText.hide()
	if $head/Camera3D/SeeCast.is_colliding():
		var target = $head/Camera3D/SeeCast.get_collider()
		if target.has_method("interact"):
			$CanvasLayer/BoxContainer/IntearctEText.show()
			print("U can pickup this item.")
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Потом допилить, если будут введены перки на double jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("run"):
		SPEED = 8.0
	else: SPEED = 5.0
	
	# Потом передавать глобальный сигнал
	#if Input.is_action_just_pressed("Select"):
		#null
		

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
