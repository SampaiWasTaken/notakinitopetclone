extends Node

signal updated_food
signal updated_fun
signal updated_love

#global Variables 
var food = 50
var fun = 50
var love = 50

func addFood(amount:float):
	food = food + amount
	if food > 100:
		food = 100
	elif food < 0:
		food = 0
	emit_signal("updated_food")

func addFun(amount:float):
	fun = fun + amount
	if fun > 100:
		fun = 100
	elif fun < 0:
		fun = 0
	emit_signal("updated_fun")

func addLove(amount:float):
	love = love + amount
	if love > 100:
		love = 100
	elif love < 0:
		love = 0
	emit_signal("updated_love")
