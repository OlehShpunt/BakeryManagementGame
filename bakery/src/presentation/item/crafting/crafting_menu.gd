class_name CraftingMenu
extends VBoxContainer

@export var recipe_data: JSON
@export var slot_style: StyleBox

var recipes: Array = []


func _ready() -> void:
	if recipe_data and recipe_data.data.has("recipes"):
		recipes = recipe_data.data.recipes
		build_crafting_ui()
	else:
		push_error("Recipe data is missing or invalid!")


func build_crafting_ui() -> void:
	for recipe in recipes:
		var hbox = create_recipe_row(recipe)
		add_child(hbox)


func create_recipe_row(recipe: Dictionary) -> HBoxContainer:
	var hbox = HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 16)
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	# 7 Ingredient Slots - 150x150
	for i in range(7):
		var slot = create_item_slot(150)
		if i < recipe.ingredients.size():
			var ingredient = recipe.ingredients[i]
			if not ingredient.is_empty():
				setup_ingredient_slot(slot, ingredient.to_lower())
		hbox.add_child(slot)

	# Spacer between ingredients and result
	var spacer = Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(spacer)

	# Result Slot - 150x150 (same size, but can look more prominent)
	var result_slot = create_item_slot(150)
	setup_result_slot(result_slot, recipe.title.to_lower())
	hbox.add_child(result_slot)

	return hbox


# SLOT CREATION
func create_item_slot(square_size: int) -> Panel:
	var slot = Panel.new()
	slot.custom_minimum_size = Vector2(square_size, square_size)
	slot.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	slot.size_flags_vertical = Control.SIZE_SHRINK_BEGIN

	if slot_style:
		slot.add_theme_stylebox_override("panel", slot_style)

	var center = CenterContainer.new()
	slot.add_child(center)

	return slot


# SETUP SLOTS
func setup_ingredient_slot(slot: Panel, item_key: String) -> void:
	var center = slot.get_child(0) as CenterContainer
	center.add_child(create_item_visual(item_key, false))


func setup_result_slot(slot: Panel, item_key: String) -> void:
	var center = slot.get_child(0) as CenterContainer
	center.add_child(create_item_visual(item_key, true))
	center.add_child(create_result_button(item_key))


# ==================== VISUAL CREATOR - Big Icon Version ====================
func create_item_visual(item_key: String, is_result: bool = false) -> VBoxContainer:
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation", 8)

	# === LARGE TEXTURE (almost filling the 150px slot) ===
	var texture_rect = TextureRect.new()

	var icon_size = 138 if not is_result else 142 # Very close to 150px

	texture_rect.custom_minimum_size = Vector2(icon_size, icon_size)
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE # Allows big size
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	var image_path = get_image_path_for_item(item_key)
	if not image_path.is_empty():
		var texture = load(image_path)
		if texture:
			texture_rect.texture = texture

	# Label (smaller text below the big icon)
	var label = Label.new()
	label.text = item_key.capitalize().replace("_", " ")
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", 20)
	label.add_theme_color_override("font_color", Color.WHITE if is_result else Color(0.9, 0.9, 0.9))

	vbox.add_child(texture_rect)
	vbox.add_child(label)

	return vbox


func create_result_button(item_key: String) -> TextureButton:
	var recipe_item := Item.new(get_item_code_for_item(item_key))
	var button := TextureButton.new()
	button.custom_minimum_size = Vector2(120, 140)
	button.pressed.connect(_on_cook_button_pressed.bind(recipe_item))
	return button


func _on_cook_button_pressed(recipe_item: Item) -> void:
	if _has_required_items(recipe_item):
		print("Can cook:", recipe_item)
	else:
		print("Not enough ingredients for:", recipe_item)


func _has_required_items(recipe_item: Item) -> bool:
	var required_counts: Dictionary[EnumHolder.ItemCode, int] = { } # count duplicates

	# Count how many times each item appears in the required_items array
	for ingredient in recipe_item._required_items:
		if ingredient == null:
			continue
		if required_counts.has(ingredient):
			required_counts[ingredient] += 1
		else:
			required_counts[ingredient] = 1

	# Check inventory for each ingredient
	for item_code in required_counts.keys():
		var required_amount: int = required_counts[item_code] # explicitly typed
		var count: int = _count_item_in_inventory(item_code)
		if count < required_amount:
			return false

	return true


func _count_item_in_inventory(item_id: int) -> int:
	var count := 0

	for cell_id in StateManager.get_player_state()._player_cell_state_ref_registry.keys():
		var item: Item = StateManager.get_player_state().get_inventory_item(cell_id)

		if item != null and item.item_code == item_id:
			count += 1

	return count


# IMAGE PATH LOOKUP
func get_image_path_for_item(item_key: String) -> String:
	match item_key:
		"flour":
			return PathHolder.FLOUR_IMAGE
		"milk":
			return PathHolder.MILK_IMAGE
		"butter":
			return PathHolder.BUTTER_IMAGE
		"chocolate":
			return PathHolder.CHOCOLATE_IMAGE
		"vanilla":
			return PathHolder.VANILLA_IMAGE
		"cocoa_powder":
			return PathHolder.COCOA_IMAGE
		"nuts":
			return PathHolder.NUTS_IMAGE
		"cherry":
			return PathHolder.CHERRY_IMAGE
		"jello":
			return PathHolder.JELLO_IMAGE
		"bread":
			return PathHolder.BREAD_IMAGE
		"bagel":
			return PathHolder.BAGEL_IMAGE
		"waffle":
			return PathHolder.WAFFLE_IMAGE
		"sponge_cake":
			return PathHolder.SPONGE_CAKE_IMAGE
		"donut":
			return PathHolder.DONUT_IMAGE
		"chocolate_candy":
			return PathHolder.CHOCOLATE_CANDY_IMAGE
		"signature_chocolate":
			return PathHolder.SIGNATURE_CHOCOLATE_IMAGE
		"pudding":
			return PathHolder.PUDDING_IMAGE
		"chocolate_bun":
			return PathHolder.CHOCOLATE_BUN_IMAGE
		"muffin":
			return PathHolder.MUFFIN_IMAGE
		"nut_candy":
			return PathHolder.NUT_CANDY_IMAGE
		"cookie":
			return PathHolder.COOKIE_IMAGE
		"nut_cake":
			return PathHolder.NUT_CAKE_IMAGE
		"cherry_cake":
			return PathHolder.CHERRY_CAKE_IMAGE
		_:
			push_warning("Unknown item key: " + item_key)
			return ""


func get_item_code_for_item(item_key: String) -> EnumHolder.ItemCode:
	match item_key:
		"flour":
			return EnumHolder.ItemCode.Flour
		"milk":
			return EnumHolder.ItemCode.Milk
		"butter":
			return EnumHolder.ItemCode.Butter
		"chocolate":
			return EnumHolder.ItemCode.Chocolate
		"vanilla":
			return EnumHolder.ItemCode.Vanilla
		"cocoa_powder":
			return EnumHolder.ItemCode.CocoaPowder
		"nuts":
			return EnumHolder.ItemCode.Nuts
		"cherry":
			return EnumHolder.ItemCode.Cherry
		"jello":
			return EnumHolder.ItemCode.Jello
		"bread":
			return EnumHolder.ItemCode.Bread
		"bagel":
			return EnumHolder.ItemCode.Bagel
		"waffle":
			return EnumHolder.ItemCode.Waffle
		"sponge_cake":
			return EnumHolder.ItemCode.SpongeCake
		"donut":
			return EnumHolder.ItemCode.Donut
		"chocolate_candy":
			return EnumHolder.ItemCode.ChocolateCandy
		"signature_chocolate":
			return EnumHolder.ItemCode.SignatureChocolate
		"pudding":
			return EnumHolder.ItemCode.Pudding
		"chocolate_bun":
			return EnumHolder.ItemCode.ChocolateBun
		"muffin":
			return EnumHolder.ItemCode.Muffin
		"nut_candy":
			return EnumHolder.ItemCode.NutCandy
		"cookie":
			return EnumHolder.ItemCode.Cookie
		"nut_cake":
			return EnumHolder.ItemCode.NutCake
		"cherry_cake":
			return EnumHolder.ItemCode.CherryCake
		_:
			push_warning("Unknown item key: " + item_key)
			return -1
