extends CanvasLayer

@onready var score_label = %ScoreLabel

func set_score(value):
	score_label.text = "SCORE: " + str(value)
