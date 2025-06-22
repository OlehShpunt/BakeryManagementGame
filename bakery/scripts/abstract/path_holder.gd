extends Node


const EMPTY = ""


## Locations
const STREET_PATH : String = "res://scenes/locations/street.tscn"
const BAKERY_1_PATH : String = "res://scenes/locations/bakery_1.tscn"
const MINI_MARKET_PATH : String = "res://scenes/locations/mini_market.tscn"
const WHOLESALE_SHOP_PATH : String = "res://scenes/locations/wholesale_shop.tscn"
const KIOSK_PATH : String = "res://scenes/locations/kiosk.tscn"
const SUPERMARKET_PATH : String = "res://scenes/locations/supermarket.tscn"


## Ingredient Scenes
const INGR_DIR_PATH = "res://scenes/food/ingredients/"
const SCENE_EXT = ".tscn"
const FLOUR_SCENE = "res://scenes/food/ingredients/flour.tscn"
const MILK_SCENE = "res://scenes/food/ingredients/milk.tscn"
const BUTTER_SCENE = "res://scenes/food/ingredients/butter.tscn"
const CHOCOLATE_SCENE = "res://scenes/food/ingredients/chocolate.tscn"
const VANILLA_SCENE = "res://scenes/food/ingredients/vanilla.tscn"
const COCOA_SCENE = "res://scenes/food/ingredients/cocoa_powder.tscn"
const NUTS_SCENE = "res://scenes/food/ingredients/nuts.tscn"
const CHERRY_SCENE = "res://scenes/food/ingredients/cherry.tscn"
const JELLO_SCENE = "res://scenes/food/ingredients/jello.tscn"

## Product Scenes
const BREAD_SCENE = "res://scenes/food/ingredients/bread.tscn"
const BAGEL_SCENE = "res://scenes/food/ingredients/bagel.tscn"
const WAFFLE_SCENE = "res://scenes/food/ingredients/waffle.tscn"
const SPONGE_CAKE_SCENE = "res://scenes/food/ingredients/sponge_cake.tscn"
const DONUT_SCENE = "res://scenes/food/ingredients/donut.tscn"
const CHOCOLATE_CANDY_SCENE = "res://scenes/food/ingredients/chocolate_candy.tscn"
const SIGNATURE_CHOCOLATE_SCENE = "res://scenes/food/ingredients/signature_chocolate.tscn"
const PUDDING_SCENE = "res://scenes/food/ingredients/pudding.tscn"
const CHOCOLATE_BUN_SCENE = "res://scenes/food/ingredients/chocolate_bun.tscn"
const MUFFIN_SCENE = "res://scenes/food/ingredients/muffin.tscn"
const NUT_CANDY_SCENE = "res://scenes/food/ingredients/nut_candy.tscn"
const COOKIE_SCENE = "res://scenes/food/ingredients/cookie.tscn"
const NUT_CAKE_SCENE = "res://scenes/food/ingredients/nut_cake.tscn"
const CHERRY_CAKE_SCENE = "res://scenes/food/ingredients/cherry_cake.tscn"


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
	"res://scenes/food/ingredients/flour.tscn": "res://assets/ingredientsPNG/flour.png",
	"res://scenes/food/ingredients/milk.tscn": "res://assets/ingredientsPNG/milk.png",
	"res://scenes/food/ingredients/butter.tscn": "res://assets/ingredientsPNG/butter.png",
	"res://scenes/food/ingredients/chocolate.tscn": "res://assets/ingredientsPNG/chocolate.png",
	"res://scenes/food/ingredients/vanilla.tscn": "res://assets/ingredientsPNG/vanilla.png",
	"res://scenes/food/ingredients/cocoa_powder.tscn": "res://assets/ingredientsPNG/cocoa_powder.png",
	"res://scenes/food/ingredients/nuts.tscn": "res://assets/ingredientsPNG/nuts.png",
	"res://scenes/food/ingredients/cherry.tscn": "res://assets/ingredientsPNG/cherry.png",
	"res://scenes/food/ingredients/jello.tscn": "res://assets/ingredientsPNG/jello.png",
	"res://scenes/food/ingredients/bread.tscn": "res://assets/ingredientsPNG/bread.png",
	"res://scenes/food/ingredients/bagel.tscn": "res://assets/ingredientsPNG/bagel.png",
	"res://scenes/food/ingredients/waffle.tscn": "res://assets/ingredientsPNG/waffle.png",
	"res://scenes/food/ingredients/sponge_cake.tscn": "res://assets/ingredientsPNG/sponge_cake.png",
	"res://scenes/food/ingredients/donut.tscn": "res://assets/ingredientsPNG/donut.png",
	"res://scenes/food/ingredients/chocolate_candy.tscn": "res://assets/ingredientsPNG/chocolate_candy.png",
	"res://scenes/food/ingredients/signature_chocolate.tscn": "res://assets/ingredientsPNG/signature_chocolate.png",
	"res://scenes/food/ingredients/pudding.tscn": "res://assets/ingredientsPNG/pudding.png",
	"res://scenes/food/ingredients/chocolate_bun.tscn": "res://assets/ingredientsPNG/chocolate_bun.png",
	"res://scenes/food/ingredients/muffin.tscn": "res://assets/ingredientsPNG/muffin.png",
	"res://scenes/food/ingredients/nut_candy.tscn": "res://assets/ingredientsPNG/nut_candy.png",
	"res://scenes/food/ingredients/cookie.tscn": "res://assets/ingredientsPNG/cookie.png",
	"res://scenes/food/ingredients/nut_cake.tscn": "res://assets/ingredientsPNG/nut_cake.png",
	"res://scenes/food/ingredients/cherry_cake.tscn": "res://assets/ingredientsPNG/cherry_cake.png"
}
