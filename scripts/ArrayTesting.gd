extends Node2D

var test_array : Array = [5, 2, 3, 7]
var turn_id : int 

func _ready():
	turn_id = get_instance_id()
	print(turn_id)
	print(test_array)
	test_array.erase(2)
	print(test_array)
	test_array.insert(0,4)
	print(test_array)
	print(test_array.find(7))
	print(test_array.size())
	_funny_test(Vector2(2,-1),null)
	_funny_test(Vector2(2,-1),get_instance_id())
	
	
func _funny_test(pos : Vector2, id):
	if id == null:
		print("id is null")
	else:
		print(str(pos) + ", ID: " + str(id))

