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
			"easy": [
				{
					"scene_name": "1",
					"unlocked": true
					#More data here such as "highscore", etc
				}
			],
			"medium": [],
			"hard": []
		}
	},
	"freeroam": {
		"display_name": "FREE ROAM LEVELS",
		"location_of_levels": "res://scenes/levels/final/freeroam/",
		"level_list": {
			"easy": [
				{
					"scene_name": "1",
					"unlocked": true
					#More data here such as "highscore", etc
				}
			],
			"medium": [],
			"hard": []
		}
	}
}
