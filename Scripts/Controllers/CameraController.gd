extends Spatial

onready var camera = get_node("Camera")
onready var rotateSpeed = .5
onready var rotateSmoothing = 10
onready var rotateLimits = [-89, 89]
onready var zoomSpeed = 5
onready var zoomSmoothing = 10
onready var zoomLimits = [30, 50]

var yaw = 90
var pitch = -35
var zoom = 50

var doRotate

func _process(delta):
	var targetPitch = lerp(rotation_degrees.x, pitch, delta * rotateSmoothing)
	var targetYaw = lerp(rotation_degrees.y, yaw, delta * rotateSmoothing)
	var targetZoom = lerp(camera.fov, zoom, delta * zoomSmoothing)
	
	rotation_degrees = Vector3(targetPitch, targetYaw, 0)
	camera.fov = targetZoom
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			doRotate = event.pressed
		if event.button_index == BUTTON_WHEEL_DOWN:
			zoom = clamp(zoom + zoomSpeed, zoomLimits[0], zoomLimits[1])
		if event.button_index == BUTTON_WHEEL_UP:
			zoom = clamp(zoom - zoomSpeed, zoomLimits[0], zoomLimits[1])
	
	if doRotate:
		if event is InputEventMouseMotion:
			yaw -= event.relative.x * rotateSpeed
			#pitch -= event.relative.y * rotateSpeed
			pitch = clamp(pitch - event.relative.y * rotateSpeed, rotateLimits[0], rotateLimits[1])
	pass