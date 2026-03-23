class_name PlayerSpawnCoordinatesResolver
extends RefCounted

static func resolve(current: EnumHolder.Location, destination: EnumHolder.Location) -> Vector2:
	print("[DEBUG] PlayerSpawnCoordinatesResolver: Current = %s; Destination = %s" % [current, destination])
	match current:
		EnumHolder.Location.Bakery1:
			return Vector2(975, 175)
		EnumHolder.Location.Supermarket:
			return Vector2(1025, 1445)
		EnumHolder.Location.MiniMarket:
			return Vector2(1775, 180)
		EnumHolder.Location.WholesaleShop:
			return Vector2(95, 425)
		EnumHolder.Location.Kiosk:
			return Vector2(530, 1550)
		EnumHolder.Location.Street:
			match destination:
				EnumHolder.Location.Bakery1:
					return Vector2(497, 275)
				EnumHolder.Location.Supermarket:
					return Vector2(560, 265)
				EnumHolder.Location.MiniMarket:
					return Vector2(288, 254)
				EnumHolder.Location.WholesaleShop:
					return Vector2(111, 254)
				EnumHolder.Location.Kiosk:
					return Vector2(495, 274)
				_:
					return Vector2(0, 0)

	return Vector2(50, 50)
