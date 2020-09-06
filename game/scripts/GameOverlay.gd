extends CanvasLayer

func setColours(g, b, o, p):
	$PieChart.setColours(g, b, o, p)
	$PieChart.update()
	$LabelScore.text = "green - " + String(int(g*100)) + "%\nblue - " + String(int(b*100)) + "%\norange - " + String(int(o*100)) + "%\npink - " + String(int(p*100)) + "%\nfree - " + String(int((1.0 - g - b - o - p) * 100)) + "%"
