extends Line2D

var target
var point

export(NodePath) var targetPath
export var trail_length = 0

func _ready():
	target = get_node(targetPath)

func _process(_delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	point = target.global_position
	self.add_point(point)
	while self.get_point_count() > trail_length:
		self.remove_point(0)
