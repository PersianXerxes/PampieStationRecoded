/datum/round_event_control/mass_hallucination
	name = "Mass Hallucination"
	typepath = /datum/round_event/mass_hallucination
	weight = 10
	max_occurrences = 5
	min_players = 1
	var/forced_hallucination

/datum/round_event_control/mass_hallucination/admin_setup()
	if(!check_rights(R_FUN))
		return

	forced_hallucination = input(usr, "Choose the hallucination to apply","Send Hallucination") as null|anything in subtypesof(/datum/hallucination)

/datum/round_event/mass_hallucination
	fakeable = FALSE

/datum/round_event/mass_hallucination/start()
	var/datum/round_event_control/mass_hallucination/M = control
	if(M.forced_hallucination)
		for(var/mob/living/carbon/C in GLOB.alive_mob_list)
			if (HAS_TRAIT(C,TRAIT_EXEMPT_HEALTH_EVENTS))
				continue
			new M.forced_hallucination(C, TRUE)
		return

	switch(rand(1,4))
		if(1) //same sound for everyone
			var/sound = pick("airlock","airlock_pry","console","explosion","far_explosion","mech","glass","alarm","beepsky","mech","wall_decon","door_hack","tesla")
			for(var/mob/living/carbon/C in GLOB.alive_mob_list)
				new /datum/hallucination/sounds(C, TRUE, sound)
		if(2)
			var/weirdsound = pick("phone","hallelujah","highlander","hyperspace","game_over","creepy","tesla")
			for(var/mob/living/carbon/C in GLOB.alive_mob_list)
				new /datum/hallucination/weird_sounds(C, TRUE, weirdsound)
		if(3)
			var/stationmessage = pick("ratvar","shuttle_dock","blob_alert","malf_ai","meteors","supermatter")
			for(var/mob/living/carbon/C in GLOB.alive_mob_list)
				new /datum/hallucination/stationmessage(C, TRUE, stationmessage)
		if(4 to 6)
			var/picked_hallucination = pick(	/datum/hallucination/bolts,
												/datum/hallucination/chat,
												/datum/hallucination/message,
												/datum/hallucination/bolts,
												/datum/hallucination/fake_flood,
												/datum/hallucination/battle,
												/datum/hallucination/fire,
												/datum/hallucination/self_delusion,
												/datum/hallucination/death,
												/datum/hallucination/delusion,
												/datum/hallucination/oh_yeah)
			for(var/mob/living/carbon/C in GLOB.alive_mob_list)
				if (HAS_TRAIT(C,TRAIT_EXEMPT_HEALTH_EVENTS))
					continue
				new picked_hallucination(C, TRUE)
