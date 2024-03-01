extends Node2D

var planets = [] #store all planets in the scene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() #randomise seed - must be called at least once per game
	spawn_planets()
	
	
func spawn_planets():
	var planets_positions = GameManager.get_marker_positions() #get all possible marker positions
	for planet_pos in planets_positions:
		var planet_instance = GameManager.PLANET.instantiate()
		planet_instance.global_position = planet_pos #assign position
		planet_instance.texture = GameManager.pick_random_texture() #get random texture for planet
		
		#get the id that godot gave automatically to this instance
		planet_instance.id = planet_instance.get_instance_id() 
		#add to array for future use
		planets.append(planet_instance)
		
		#show this instance in the scene
		add_child(planet_instance)
	
	#after spawning all planets, assign id_target for each planet
	assign_target_ids()	
		
func assign_target_ids():
	if(planets.size() > 1): #check if there are enough planets
		for planet in planets:
			var target_index=randi_range(0,planets.size()-1)	
			var target_planet = planets[target_index]
			#if they are the same,do again the random
			while target_planet == planet: 
				target_index = randi_range(0,planets.size()-1)
				target_planet = planets[target_index]
			#every planet now has a target planet
			planet.id_target = target_planet.id	
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for planet in planets:
		#find the target planet based on id_target
		var target_planet = find_planet_by_id(planet.id_target)
		if(target_planet): #if target_planet is not null
			#update the target position
			planet.set_target(target_planet.global_position)

func find_planet_by_id(id):
	for planet in planets:
		if(planet.id == id):
			return planet
	return null
	
