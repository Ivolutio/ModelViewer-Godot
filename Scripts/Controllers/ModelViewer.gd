extends Spatial

onready var models = [ 
	preload("res://Models/Gemrock.tscn"), 
	preload("res://Models/Tree.tscn")
]
var modelIndex = 0;
var currentModel

func _ready():
	_setModel(modelIndex)
	pass

func nextModel():
	if modelIndex >= models.size()-1:
		modelIndex = 0
	else:
		modelIndex += 1
	_setModel(modelIndex)
	pass
	
func prevModel():
	if modelIndex <= 0:
		modelIndex = models.size()-1
	else:
		modelIndex -= 1
	_setModel(modelIndex)
	pass
	
func _setModel(index):
	var model = models[index].instance()
	if currentModel != null:
		currentModel.queue_free()
	add_child(model)
	currentModel = model
	pass
