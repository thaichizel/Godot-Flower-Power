extends Node2D



# Variables
var flowerSpawnTimer : float = 0
const FLOWER_SPAWN_INTERVAL : float = 1  # Adjust this interval as needed

var powerSpawnTimer : float = 0
const POWER_SPAWN_INTERVAL : float = 10.0

var flowerTextures := [
	preload("res://Assets/Artwork/flower0.png"),
	preload("res://Assets/Artwork/flower1.png"),
	preload("res://Assets/Artwork/flower2.png"),
	preload("res://Assets/Artwork/flower3.png"),
	preload("res://Assets/Artwork/flower4.png"),
	preload("res://Assets/Artwork/flower5.png")
]

var flowerDatabase = {}  # Dictionary to store flower data
var flowerID : int = 0  # Unique ID for each flower
var playerScore : int = 0  # Player's score

func _ready():
	randomize()

func _process(delta: float) -> void:
	# Update the flower spawn timer
	flowerSpawnTimer += delta
	# Update the power spawn timer
	powerSpawnTimer += delta

	# Check if it's time to spawn a flower
	if flowerSpawnTimer >= FLOWER_SPAWN_INTERVAL:
		spawn_flower()
		flowerSpawnTimer = 0  # Reset the timer

	# Check if it's time to spawn a power-up
	if powerSpawnTimer >= POWER_SPAWN_INTERVAL:
		spawn_power()
		powerSpawnTimer = 0

func spawn_flower():
	# Choose a random flower texture
	var randomTextureIndex = randi() % flowerTextures.size()
	var selectedTexture = flowerTextures[randomTextureIndex]

	# Create a new flower sprite
	var newFlower = Sprite2D.new()
	newFlower.texture = selectedTexture

	# Set random position within your game area
	var randomX = randf_range(50, 1102)
	var randomY = randf_range(50, 598)
	newFlower.global_position = Vector2(randomX, randomY)

	# Add the flower instance to the scene
	add_child(newFlower)

	# Create a CollisionShape2D for input events
	var collisionShape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = newFlower.texture.get_size() / 2
	collisionShape.shape = shape

	# Set the collision shape's position relative to the flower sprite
	collisionShape.position = newFlower.texture.get_size() / 2

	# Add the collision shape as a child of the newFlower
	newFlower.add_child(collisionShape)

	# Assign a unique ID to the flower and store it in the database
	newFlower.set("flowerID", flowerID)
	flowerDatabase[flowerID] = {
		"texture": selectedTexture,
		"position": Vector2(randomX, randomY),
		"instance": newFlower,
		"collisionShape": collisionShape
	}
	flowerID += 1

	# Connect the input event to the collision shape
	collisionShape.connect("input_event", Callable(self, "_on_flower_input"))

func spawn_power() -> void:
	# Set random position within the game area
	var randomX = randf_range(50, 1102)  # Adjust min/max X values
	var randomY = randf_range(50, 598)   # Adjust min/max Y values

	var newPower = Sprite2D.new()
	newPower.texture = preload("res://Assets/Artwork/power1.png")
	newPower.global_position = Vector2(randomX, randomY)

	add_child(newPower)

func _on_flower_input(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var clickedFlowerID = flowerDatabase[get_tree().get_root().get_node("Game").flowerID]
		var flowerData = flowerDatabase[clickedFlowerID]
	print_debug("Something")
		
		# Determine the Player Points  Are ofSo AlsoThIt Single ThingBut PlayerThe Can useContext Know
