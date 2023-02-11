extends RigidBody2D
export var float_chance = 2

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	self.set_gravity_scale(0.01)

func _physics_process(delta):
	if rng.randi() % 100 < float_chance:
		self.add_central_force(Vector2(rng.randf_range(-0.05, 0.05),-0.001))
