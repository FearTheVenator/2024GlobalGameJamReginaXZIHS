extends Node3D

var actualBuilding = preload("res://scenes/building_type_a.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	## get all the fake buildings
	#var fakers = $floor/buildings/fakeBuildings.get_children()
	## for each fake building, instantiate a new actual building
	#for fake in fakers:
		#var actualBuilding = actualBuilding.instantiate()
		#actualBuilding.position = fake.position
	## add new instance as a child to the level
		#$floor/buildings/actualBuildings.add_child(actualBuilding)
	#print("added all the actual buildings lol.")
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
