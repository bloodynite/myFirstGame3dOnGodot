extends Node

export (PackedScene) var mob_scene

func _ready():
	randomize()
	$UserInterface/Retry.hide()


func _on_MobTimer_timeout():
	#Crea una nueva instancia de la escena
	var mob = mob_scene.instance()
	
	#Elige una ubicacion random en SpawnPath
	#Almacenaremos la referencia para el nodo de SpawnLocation
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	
	#le pasamos no se???
	mob_spawn_location.unit_offset = randf()
	var player_position = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_position)
	mob.connect("squashed", $UserInterface/ScoreLabel, '_on_Mob_squashed')
	
	add_child(mob)


func _on_Player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed('ui_accept') and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
