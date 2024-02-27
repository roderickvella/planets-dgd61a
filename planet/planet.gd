extends CharacterBody2D
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

@export var speed =150 #default speed for out moving planet
@export var target:Vector2 = Vector2(100,100) #default target to move to

var dragging =false #flag to know if we are dragging or not
var touch_position = Vector2() #stores the touch position

#identification
var id: int #the id of this instance
var id_target:int #the id of the instance that this instance is going to follow

#visual
var texture: Texture #set via code (chosen texture for this instance)


# Called when the node enters the scene tree for the first time.
func _ready():
	if(texture): #update the texture with the texture chosen via code
		sprite.texture = texture

#called to change the target position
func set_target(target_pos):
	target = target_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		#update the touch position while dragging
		touch_position = get_viewport().get_mouse_position()
		#update the node's position
		global_position = touch_position

#called when there is an input event such as key press, mouse movement or touch event
func _input(event):
	#to enable touch event we need to go to the project settings and enable
	#"Emulate Touch From Mouse" setting
	if event is InputEventScreenTouch:
		touch_position = event.position #fills up touch_position with where the user is clicking
		
		#calculate global rect of the actor.
		var actor_global_rect = Rect2(global_position - sprite.texture.get_size() 
		* sprite.scale *0.5, sprite.texture.get_size() * sprite.scale)
		
		#check if the touch is on the node
		if(event.pressed and actor_global_rect.has_point(touch_position)):
			dragging =true
		elif not event.pressed:
			dragging =false
		

func _physics_process(delta):
	#calculate the direction vector from the current position to the target position
	#'direction_to' returns a normalised vector pointing from 'position' towards target
	var velocity = position.direction_to(target)*speed
	var collision = move_and_collide(velocity*delta)	
	if(collision):#if collision is not empty
		
		#get the object that was collided with
		var other_collided_object = collision.get_collider()
		print_debug("Collision Detected") 
		

