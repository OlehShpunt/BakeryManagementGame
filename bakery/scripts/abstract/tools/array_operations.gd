class_name array_operations
extends Node


## Returns difference between two arrays
static func a_minus_b(a: Array, b: Array) -> Array:
	var b_copy = b.duplicate()
	var result = []

	for item in a:
		if b_copy.has(item):
			b_copy.erase(item)  # removes one occurrence
		else:
			result.append(item)

	return result


## Returns intersection between two arrays
static func intersection_of(a: Array, b: Array) -> Array:
	var result := []
	var b_counts := {}

	# Count occurrences in b
	for item in b:
		b_counts[item] = b_counts.get(item, 0) + 1

	# For each item in a, include it if b still has a count left
	for item in a:
		if b_counts.get(item, 0) > 0:
			result.append(item)
			b_counts[item] -= 1

	return result
