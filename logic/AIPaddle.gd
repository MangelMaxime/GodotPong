extends Area2D

enum Behaviour {
	DIRECT_CATCH,
	IDLE_MOVE_TO_CENTER,
	IDLE_UP_AND_DOWN_ON_PLACE
}

export var MOVE_SPEED = 150
export var IDLE_MOVE_SPEED = 40

onready var ball : Ball = get_node("../Ball")
onready var CollisionShape : Vector2 = $CollisionShape2D.shape.extents

var currentBehaviour = Behaviour.DIRECT_CATCH
var rng = RandomNumberGenerator.new()

var idle_up_and_down_on_place_state = null

func _ready():
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# The ball is coming in the direction of the paddle
	# Implement the logic for "catching" the ball
	if ball.direction.x < 0:

		# Update the behaviour, for now it is used just to give different "idle" behaviours
		match currentBehaviour:
			Behaviour.DIRECT_CATCH:
				pass
			_:
				currentBehaviour = Behaviour.DIRECT_CATCH

		# If the ball is upper than the paddle top section, move the paddle down
		if ball.position.y < self.position.y - CollisionShape.y / 2:
			self.position.y = self.position.y - MOVE_SPEED * delta
		# If the ball is lower than the paddle top section, move the paddle down
		elif ball.position.y > self.position.y + CollisionShape.y / 2:
			self.position.y = self.position.y + MOVE_SPEED * delta

	# The ball is moving away from the paddle
	# Implements "idle" logic
	else:

		match currentBehaviour:
			Behaviour.DIRECT_CATCH:
				# Just entering idle behaviour choose an idle behaviour randomly
				match rng.randi_range(1, 2):
					1:
						currentBehaviour = Behaviour.IDLE_MOVE_TO_CENTER
					2:
						currentBehaviour = Behaviour.IDLE_UP_AND_DOWN_ON_PLACE
						idle_up_and_down_on_place_state = {
							initial_position = self.position.y,
							move_direction = "DOWN"
						}
			_:
				pass

		match currentBehaviour:
			Behaviour.DIRECT_CATCH:
				# Impossible state here
				pass

			Behaviour.IDLE_MOVE_TO_CENTER:
				idle_move_to_center(delta)

			Behaviour.IDLE_UP_AND_DOWN_ON_PLACE:
				idle_up_and_down_on_place(delta)


func idle_up_and_down_on_place(delta):
	var positionDelta = idle_up_and_down_on_place_state.initial_position - self.position.y
	if positionDelta < -15 and idle_up_and_down_on_place_state.move_direction == "DOWN":
		self.position.y = self.position.y + IDLE_MOVE_SPEED * delta
		idle_up_and_down_on_place_state.move_direction = "UP"
	elif positionDelta > 15  and idle_up_and_down_on_place_state.move_direction == "UP":
		self.position.y = self.position.y - IDLE_MOVE_SPEED * delta
		idle_up_and_down_on_place_state.move_direction = "DOWN"
	else:
		if idle_up_and_down_on_place_state.move_direction == "DOWN":
			self.position.y = self.position.y + IDLE_MOVE_SPEED * delta
		else:
			self.position.y = self.position.y - IDLE_MOVE_SPEED * delta


func idle_move_to_center(delta):
		if self.position.y < 300:
			self.position.y = clamp(self.position.y + MOVE_SPEED * delta, 0, 300)
		else:
			self.position.y = clamp(self.position.y - MOVE_SPEED * delta, 300, 600)


func _on_area_entered(area):
	if area.name == "Ball":
		area.bounce(self.position, 1)
