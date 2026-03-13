class_name Finance extends Node


static func resolve_price(item_path: String):
	match item_path:
		path_holder.BREAD_SCENE:
			return 3
		path_holder.BAGEL_SCENE:
			return 5
		path_holder.WAFFLE_SCENE:
			return 5
		path_holder.SPONGE_CAKE_SCENE:
			return 6
		path_holder.DONUT_SCENE:
			return 16
		path_holder.CHOCOLATE_CANDY_SCENE:
			return 13
		path_holder.SIGNATURE_CHOCOLATE_SCENE:
			return 11
		path_holder.PUDDING_SCENE:
			return 14
		path_holder.CHOCOLATE_BUN_SCENE:
			return 13
		path_holder.MUFFIN_SCENE:
			return 9
		path_holder.NUT_CANDY_SCENE:
			return 18
		path_holder.COOKIE_SCENE:
			return 19
		path_holder.NUT_CAKE_SCENE:
			return 34
		path_holder.CHERRY_CAKE_SCENE:
			return 28
		path_holder.FLOUR_SCENE:
			return 1
		path_holder.MILK_SCENE:
			return 2
		path_holder.BUTTER_SCENE:
			return 3
		path_holder.CHOCOLATE_SCENE:
			return 2
		path_holder.VANILLA_SCENE:
			return 2
		path_holder.COCOA_SCENE:
			return 3
		path_holder.NUTS_SCENE:
			return 4
		path_holder.CHERRY_SCENE:
			return 3
		path_holder.JELLO_SCENE:
			return 4
		_:
			return 1000  # TODO replace with 0 after testing
