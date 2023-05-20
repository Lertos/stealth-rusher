extends Node

#========================
# This is the level setup singleton class. The organization is as follows:
#	(level type) example: "dashing"
#		(level meta data) example: { "display_name": "Dash levels", "level_list": [] }
#			(level list - int indicies) example: 1: { ... }
#========================

var levels = {
	"dashing": {
		"display_name": "DASH LEVELS",
		"location_of_levels": "res://scenes/levels/final/dash/",
		"level_list": {
			Enums.level_difficulty.EASY: [
				{
					"scene_name": "1",
					"unlocked": true
					#More data here such as "highscore", etc
				}
			],
			Enums.level_difficulty.MEDIUM: [],
			Enums.level_difficulty.HARD: []
		}
	},
	"freeroam": {
		"display_name": "FREE ROAM LEVELS",
		"location_of_levels": "res://scenes/levels/final/freeroam/",
		"level_list": {
			Enums.level_difficulty.EASY: [
				{
					"scene_name": "1",
					"unlocked": true
					#More data here such as "highscore", etc
				}
			],
			Enums.level_difficulty.MEDIUM: [],
			Enums.level_difficulty.HARD: []
		}
	}
}
