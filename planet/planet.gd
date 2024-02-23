extends Node
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

@export var speed =150 #default speed for out moving planet
@export var target:Vector2 = Vector2(100,100) #default target to move to

var dragging =false #flag to know if we are dragging or not
var touch_position = Vector2() #stores the touch position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#called when there is an input event such as key press, mouse movement or touch event
func _input(event):
	#to enable touch event we need to go to the project settings and enable
	#"Emulate Touch From Mouse" setting
	if event is InputEventScreenTouch:
		touch_position = event.position #fills up touch_position with where the user is clicking
		
		
	
