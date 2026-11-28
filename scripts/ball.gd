extends RigidBody2D

@onready var pigeon_hit = get_node("../PigeonHit")

# written by adrian

@export var jump_impulse := 1000.0
@export var movement_threshold := 700

var should_teleport: bool = false
var target_pos: Vector2 = Vector2.ZERO

var physics_timer: float = 2.5
var physics_duration: float = 2.0
var is_physics_timer_active: bool = true
var has_touched_ground: bool = false
var has_thrown: bool = false
var num_of_birds: int = 0

func _ready() -> void:
	Globals.throw_finished.connect(_on_throw_finished)

func _input(event: InputEvent) -> void:
	
	#var shoot_dir := global_position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed("launch") and has_touched_ground:
		target_pos = get_global_mouse_position()
		print(target_pos)
		Globals.throw_in_progress.emit(true)
		has_touched_ground = false
		has_thrown = true
		#apply_central_impulse(shoot_dir * jump_impulse)

func _process(delta: float) -> void:
	
	if Globals.in_motion == true:
		self.visible = true
	else:
		self.visible = false
	
	#if Globals.in_motion == false:
	#	look_at(get_global_mouse_position())		
	
	#if ((linear_velocity.length_squared() > movement_threshold) or (angular_velocity > movement_threshold) and has_touched_ground == false):
	#	Globals.in_motion = true
	#	self.visible = true
	#else:
	#	Globals.in_motion = false
	#	self.visible = false
		
func _on_throw_finished() -> void:
	self.sleeping = false
	should_teleport = true
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	print("transforming to " and target_pos)
	if should_teleport == true:
		state.transform.origin = Vector2(target_pos.x, 0)
		state.linear_velocity = Vector2.ZERO # Optional: stops old momentum
		should_teleport = false

func _on_body_entered(body: Node) -> void:
	if (body.name == "GroundStaticBody"):
		has_touched_ground = true
		num_of_birds = 0
		
	if (body.name == "AnimatableBody2D"):
		num_of_birds += 1
		Globals.score += (150 * num_of_birds)
		pigeon_hit.play()
		if num_of_birds > 1:
			Globals.multiplier = num_of_birds
			Globals.canSee = true
			%AnimationPlayer.play("Fade")
			
