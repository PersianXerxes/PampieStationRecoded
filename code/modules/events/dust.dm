/datum/round_event_control/space_dust
	name = "Minor Space Dust"
	typepath = /datum/round_event/space_dust
	weight = 200
	max_occurrences = 1000
	earliest_start = 0 MINUTES
	alert_observers = FALSE

/datum/round_event/space_dust
	startWhen		= 1
	endWhen			= 2
	fakeable = FALSE

/datum/round_event/space_dust/start()
	spawn_meteors(1, GLOB.meteorsC)

/datum/round_event_control/sandstorm
	name = "Sandstorm"
	typepath = /datum/round_event/sandstorm
	weight = 5
	max_occurrences = 1
	min_players = 5
	earliest_start = 20 MINUTES

/datum/round_event/sandstorm
	startWhen = 1
	endWhen = 150 // ~5 min
	announceWhen = 0
	fakeable = FALSE

/datum/round_event/sandstorm/tick()
	spawn_meteors(10, GLOB.meteorsC)
