extends Node

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

func pick_random_texture() -> Texture:
	#randomise the seed
	randomize()	
	
	#pick a random index based on the size of the 
	#planets_texures array
	var random_index = randi() % planets_textures.size()
	#return the texture using the random index
	return planets_textures[random_index]
	
	
	
	

