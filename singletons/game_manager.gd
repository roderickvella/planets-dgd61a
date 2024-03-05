extends Node

signal on_planet_collision(planet,other_planet)

#planets textures
var planets_textures = [
	preload("res://images/planet00.png"),
	preload("res://images/planet01.png"),
	preload("res://images/planet02.png"),
	preload("res://images/planet03.png"),
	preload("res://images/planet04.png"),
	preload("res://images/planet05.png"),
	preload("res://images/planet06.png"),
	preload("res://images/planet07.png"),
	preload("res://images/planet08.png"),
	preload("res://images/planet09.png")
]

#scenes
const PLANET = preload("res://planet/planet.tscn")
const PLANET_MARKERS_LEVEL_1 = preload("res://planet_markers/planet_markers_level1.tscn")
const PLANET_MARKERS_LEVEL_2 = preload("res://planet_markers/planet_markers_level2.tscn")
var planet_markers_scenes = [PLANET_MARKERS_LEVEL_1,PLANET_MARKERS_LEVEL_2]
const EXPLOSION = preload("res://explosion/explosion.tscn")

#current level
var current_level = 1 #0 means level 1, 1 means level 2

#get all maker positions according to selected level
func get_marker_positions()->Array:
	var positions = []
	var level_instance = planet_markers_scenes[current_level].instantiate() #create in memory
	for marker in level_instance.get_children(): #get markers
		if marker is Marker2D: 
			positions.append(marker.global_position) #add the position of every marker in array
	
	level_instance.queue_free() #free (remove) the instance scene (we no longer need this)
	return positions
			
	



func pick_random_texture() -> Texture:
	#randomise the seed
	randomize()	
	
	#pick a random index based on the size of the 
	#planets_texures array
	var random_index = randi() % planets_textures.size()
	#return the texture using the random index
	return planets_textures[random_index]
	
	
	
	

