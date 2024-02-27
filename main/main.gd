extends Node2D

var planets = [] #store all planets in the scene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() #randomise seed - must be called at least once per game
	spawn_planets()
	
	
func spawn_planets():
	var planets_positions = GameManager.get_marker_positions() #get all possible marker positions
	for planet_pos in planets_positions:
		pass  #next lecture we will create an instance of planet for every planet_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
