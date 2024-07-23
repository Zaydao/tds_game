extends ProgressBar


var parent
var max_value_amount
var min_value_amount

func _ready():
	parent = get_parent()
	print(parent)
	
	max_value_amount = parent.hp
	min_value_amount = parent.min_hp
	self.max_value = parent.hp

func _process(delta):
	
	self.value = parent.hp
	if parent.hp != max_value_amount:
		self.visible = true
		if parent.hp == min_value_amount:
			self.visible = false
	else:
		self.visible = false

	
	
	
