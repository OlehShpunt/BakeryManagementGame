## Contains recipy-related algorithms and features.
#TODO: Relocate JSON load-related actions to the class itself.
class_name RecipeManager
extends Node

var json = JSON.new()

## Loads the contents of the JSON 
## file and compares the given ingredient list to the recipes.
## Returns the result item name if the given ingredients match a recipe.
## Else, returns "".
static func get_recipe_result(given_ingredients : Array) -> String:
	var file = FileAccess.open("res://resources/json/recipes.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var recipes = data["recipes"]
	for recipe in recipes:
		var recipe_result = recipe["title"]
		var recipe_ingredients = recipe["ingredients"]
		given_ingredients.sort()
		print("Cook > given_ingredients = ", given_ingredients)
		recipe_ingredients.sort()
		print("Cook > recipe_ingredients = ", recipe_ingredients)
		
		if (str(given_ingredients) == str(recipe_ingredients)):
			return recipe_result
	return ""
