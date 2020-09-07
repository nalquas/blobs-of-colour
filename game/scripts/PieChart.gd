extends Control

export (int) var radius = 128
export (int) var outline = 5
export (float) var step_size = (2*PI) / 360.0#0.01

# Colour values
var green = Color("#6abe30")
var blue = Color("#639bff")
var orange = Color("#df7126")
var pink = Color("#d95763")
var grey = Color("#847e87")

# Fractions
var fraction_green = 0.0
var fraction_blue = 0.0
var fraction_orange = 0.0
var fraction_pink = 0.0
var fraction_grey = 1.0

func setColours(g, b, o, p):
	fraction_green = g
	fraction_blue = b
	fraction_orange = o
	fraction_pink = p
	fraction_grey = 1.0 - g - b - o - p

func _draw():
	# Background circle, black
	draw_circle(Vector2(0, 0), radius+outline, Color("#222034"))
	
	# Arcs of colour
	var end_last = -0.5*PI
	for i in range(0, 5):
		# Select colour to process
		var fraction = fraction_green
		var colour = green
		match i:
			1:
				fraction = fraction_blue
				colour = blue
			2:
				fraction = fraction_orange
				colour = orange
			3:
				fraction = fraction_pink
				colour = pink
			4:
				fraction = fraction_grey
				colour = grey
		
		var end = end_last + fraction * 2*PI
		
		# Calculate points of arc
		var points = PoolVector2Array()
		points.append(Vector2(0.0, 0.0)) # Origin
		var pos = end_last
		while (i<4 and pos <= end) or (i==4 and pos <= 1.5*PI):
			points.append(radius * Vector2(cos(pos), sin(pos)))
			pos += step_size
		
		# Draw arc
		if points.size() >= 3:
			draw_colored_polygon(points, colour)
		end_last = pos - step_size
