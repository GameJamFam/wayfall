extends RigidBody2D
export (Array, AudioStream) var hit_sounds
export var float_chance = 2

onready var audio_player = $AudioStreamPlayer2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	self.set_gravity_scale(0.01)

func _physics_process(delta):
	if rng.randi() % 100 < float_chance:
		self.add_central_force(Vector2(0, rng.randf_range(-0.01, 0.01)))

func _on_Cuke_body_entered(body:Node):
	audio_player.set_stream(hit_sounds[rng.randi() % hit_sounds.size()])
	audio_player.play()
