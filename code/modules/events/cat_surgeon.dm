/datum/round_event_control/cat_surgeon
	name = "Cat Surgeon"
	typepath = /datum/round_event/cat_surgeon
	weight = 4
	min_players = 2
	max_occurrences = 1

/datum/round_event/cat_surgeon/announce(fake)
	priority_announce("One of our... ahem... 'special' cases has escaped. As it happens their last known location before their tracker went dead is your station so keep an eye out for them. On an unrelated note, has anyone seen our cats?",
	sender_override = "Nanotrasen Psych Ward")

/datum/round_event/cat_surgeon/start()
    var/list/spawn_locs = list()
    for(var/X in GLOB.xeno_spawn)
        spawn_locs += X

    if(!spawn_locs.len)
        message_admins("No valid spawn locations found, aborting...")
        return MAP_ERROR

    var/turf/T = get_turf(pick(spawn_locs))
    var/mob/living/simple_animal/hostile/cat_butcherer/S = new(T)
    playsound(S, 'sound/misc/catscream.ogg', 75, 1, -1)
    message_admins("A cat surgeon has been spawned at [COORD(T)][ADMIN_JMP(T)]")
    log_game("A cat surgeon has been spawned at [COORD(T)]")
    return SUCCESSFUL_SPAWN
