# TODO: Separate into several holders
class_name PathHolder
extends Node

const EMPTY = ""

## Locations
static var LOCATIONS_PATH: String = "res://src/presentation/location"
static var STREET_PATH: String = LOCATIONS_PATH + "/street/street.tscn"
static var BAKERY_PATH: String = LOCATIONS_PATH + "/bakery/bakery.tscn"
static var BAKERY_1_PATH: String = LOCATIONS_PATH + "/bakery/bakery_1.tscn"
static var MINI_MARKET_PATH: String = LOCATIONS_PATH + "/mini_market/mini_market.tscn"
static var WHOLESALE_SHOP_PATH: String = LOCATIONS_PATH + "/wholesale_shop/wholesale_shop.tscn"
static var KIOSK_PATH: String = LOCATIONS_PATH + "/kiosk/kiosk.tscn"
static var SUPERMARKET_PATH: String = LOCATIONS_PATH + "/supermarket/supermarket.tscn"

## Player
static var PLAYER_SCENE_PATH: String = "res://src/presentation/player/player.tscn"

## Ingredient Scenes
const INGR_DIR_PATH = "res://src/presentation/item/food"
const SCENE_EXT = ".tscn"
const FLOUR_SCENE = INGR_DIR_PATH + "/flour.tscn"
const MILK_SCENE = INGR_DIR_PATH + "/milk.tscn"
const BUTTER_SCENE = INGR_DIR_PATH + "/butter.tscn"
const CHOCOLATE_SCENE = INGR_DIR_PATH + "/chocolate.tscn"
const VANILLA_SCENE = INGR_DIR_PATH + "/vanilla.tscn"
const COCOA_SCENE = INGR_DIR_PATH + "/cocoa_powder.tscn"
const NUTS_SCENE = INGR_DIR_PATH + "/nuts.tscn"
const CHERRY_SCENE = INGR_DIR_PATH + "/cherry.tscn"
const JELLO_SCENE = INGR_DIR_PATH + "/jello.tscn"

## Product Scenes
const BREAD_SCENE = INGR_DIR_PATH + "/bread.tscn"
const BAGEL_SCENE = INGR_DIR_PATH + "/bagel.tscn"
const WAFFLE_SCENE = INGR_DIR_PATH + "/waffle.tscn"
const SPONGE_CAKE_SCENE = INGR_DIR_PATH + "/sponge_cake.tscn"
const DONUT_SCENE = INGR_DIR_PATH + "/donut.tscn"
const CHOCOLATE_CANDY_SCENE = INGR_DIR_PATH + "/chocolate_candy.tscn"
const SIGNATURE_CHOCOLATE_SCENE = INGR_DIR_PATH + "/signature_chocolate.tscn"
const PUDDING_SCENE = INGR_DIR_PATH + "/pudding.tscn"
const CHOCOLATE_BUN_SCENE = INGR_DIR_PATH + "/chocolate_bun.tscn"
const MUFFIN_SCENE = INGR_DIR_PATH + "/muffin.tscn"
const NUT_CANDY_SCENE = INGR_DIR_PATH + "/nut_candy.tscn"
const COOKIE_SCENE = INGR_DIR_PATH + "/cookie.tscn"
const NUT_CAKE_SCENE = INGR_DIR_PATH + "/nut_cake.tscn"
const CHERRY_CAKE_SCENE = INGR_DIR_PATH + "/cherry_cake.tscn"

## Ingredient Images
const FLOUR_IMAGE = "res://assets/ingredientsPNG/flour.png"
const MILK_IMAGE = "res://assets/ingredientsPNG/milk.png"
const BUTTER_IMAGE = "res://assets/ingredientsPNG/butter.png"
const CHOCOLATE_IMAGE = "res://assets/ingredientsPNG/chocolate.png"
const VANILLA_IMAGE = "res://assets/ingredientsPNG/vanilla.png"
const COCOA_IMAGE = "res://assets/ingredientsPNG/cocoa_powder.png"
const NUTS_IMAGE = "res://assets/ingredientsPNG/nuts.png"
const CHERRY_IMAGE = "res://assets/ingredientsPNG/cherry.png"
const JELLO_IMAGE = "res://assets/ingredientsPNG/jello.png"

## Product Images
const BREAD_IMAGE = "res://assets/ingredientsPNG/bread.png"
const BAGEL_IMAGE = "res://assets/ingredientsPNG/bagel.png"
const WAFFLE_IMAGE = "res://assets/ingredientsPNG/waffle.png"
const SPONGE_CAKE_IMAGE = "res://assets/ingredientsPNG/sponge_cake.png"
const DONUT_IMAGE = "res://assets/ingredientsPNG/donut.png"
const CHOCOLATE_CANDY_IMAGE = "res://assets/ingredientsPNG/chocolate_candy.png"
const SIGNATURE_CHOCOLATE_IMAGE = "res://assets/ingredientsPNG/signature_chocolate.png"
const PUDDING_IMAGE = "res://assets/ingredientsPNG/pudding.png"
const CHOCOLATE_BUN_IMAGE = "res://assets/ingredientsPNG/chocolate_bun.png"
const MUFFIN_IMAGE = "res://assets/ingredientsPNG/muffin.png"
const NUT_CANDY_IMAGE = "res://assets/ingredientsPNG/nut_candy.png"
const COOKIE_IMAGE = "res://assets/ingredientsPNG/cookie.png"
const NUT_CAKE_IMAGE = "res://assets/ingredientsPNG/nut_cake.png"
const CHERRY_CAKE_IMAGE = "res://assets/ingredientsPNG/cherry_cake.png"

# Mapping of scene paths to image paths
const scene_to_image_map = {
	INGR_DIR_PATH + "/flour.tscn": "res://assets/ingredientsPNG/flour.png",
	INGR_DIR_PATH + "/milk.tscn": "res://assets/ingredientsPNG/milk.png",
	INGR_DIR_PATH + "/butter.tscn": "res://assets/ingredientsPNG/butter.png",
	INGR_DIR_PATH + "/chocolate.tscn": "res://assets/ingredientsPNG/chocolate.png",
	INGR_DIR_PATH + "/vanilla.tscn": "res://assets/ingredientsPNG/vanilla.png",
	INGR_DIR_PATH + "/cocoa_powder.tscn": "res://assets/ingredientsPNG/cocoa_powder.png",
	INGR_DIR_PATH + "/nuts.tscn": "res://assets/ingredientsPNG/nuts.png",
	INGR_DIR_PATH + "/cherry.tscn": "res://assets/ingredientsPNG/cherry.png",
	INGR_DIR_PATH + "/jello.tscn": "res://assets/ingredientsPNG/jello.png",
	INGR_DIR_PATH + "/bread.tscn": "res://assets/ingredientsPNG/bread.png",
	INGR_DIR_PATH + "/bagel.tscn": "res://assets/ingredientsPNG/bagel.png",
	INGR_DIR_PATH + "/waffle.tscn": "res://assets/ingredientsPNG/waffle.png",
	INGR_DIR_PATH + "/sponge_cake.tscn": "res://assets/ingredientsPNG/sponge_cake.png",
	INGR_DIR_PATH + "/donut.tscn": "res://assets/ingredientsPNG/donut.png",
	INGR_DIR_PATH + "/chocolate_candy.tscn": "res://assets/ingredientsPNG/chocolate_candy.png",
	INGR_DIR_PATH + "/signature_chocolate.tscn": "res://assets/ingredientsPNG/signature_chocolate.png",
	INGR_DIR_PATH + "/pudding.tscn": "res://assets/ingredientsPNG/pudding.png",
	INGR_DIR_PATH + "/chocolate_bun.tscn": "res://assets/ingredientsPNG/chocolate_bun.png",
	INGR_DIR_PATH + "/muffin.tscn": "res://assets/ingredientsPNG/muffin.png",
	INGR_DIR_PATH + "/nut_candy.tscn": "res://assets/ingredientsPNG/nut_candy.png",
	INGR_DIR_PATH + "/cookie.tscn": "res://assets/ingredientsPNG/cookie.png",
	INGR_DIR_PATH + "/nut_cake.tscn": "res://assets/ingredientsPNG/nut_cake.png",
	INGR_DIR_PATH + "/cherry_cake.tscn": "res://assets/ingredientsPNG/cherry_cake.png",
}

# Data holders

const INVENTORY_RESOURCE_PATH = "res://src/presentation/player/hud/inventory_resource.tres"
const STORAGE_1_RESOURCE_PATH = "res://src/presentation/location/shared/furniture/storage1_resource.tres"
const COOKING_GUI_RESOURCE_PATH = "res://src/presentation/location/bakery/cooking/cooking_gui_resource.tres"
const INGREDIENT_INTERACTIVE_AREA = "res://src/presentation/item/food/ingredient_interactive_area.tscn"
