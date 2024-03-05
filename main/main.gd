extends Node2D

var planets = [] #store all planets in the scene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() #randomise seed - must be called at least once per game	
	spawn_planets()
	#subscribe to any changes happening in on_planet_collision (in GameManager),
	#once a change is automatically detected call the _on_planet_collision
	GameManager.on_planet_collision.connect(_on_planet_collision)
	
func _on_planet_collision(planet,other_planet):
	explode_planets(planet,other_planet)
	
func explode_planets(planet,other_planet):
	#check that both instances are valid
	if is_instance_valid(planet) and is_instance_valid(other_planet):
		#print_debug("Explode Planets:",planet,other_planet)
		var explosion_instance = GameManager.EXPLOSION.instantiate()
		#change the explosion position
		explosion_instance.global_position = planet.global_position
		#add this explosion to the scene
		add_child(explosion_instance)
		
		var explosion_instance2 = GameManager.EXPLOSION.instantiate()
		explosion_instance2.global_position = other_planet.global_position
		add_child(explosion_instance2)
		
		#remove planets from the scene
		planet.queue_free() #remove the planet from the scene
		other_planet.queue_free()
		
		#remove the planets from the array
		planets.erase(planet)
		planets.erase(other_planet)
	
	
	
	
	
	
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
	
