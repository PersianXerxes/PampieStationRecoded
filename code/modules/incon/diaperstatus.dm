/mob/living/carbon/var/pee = 0
/mob/living/carbon/var/poop = 0
/mob/living/carbon/var/wetness = 0
/mob/living/carbon/var/stinkiness = 0
/mob/living/carbon/var/fluids = 0
/mob/living/var/max_wetcontinence = 100
/mob/living/var/max_messcontinence = 100
/mob/living/carbon/var/on_purpose = 0
/mob/living/carbon/var/brand = "plain"
/mob/living/carbon/var/brand2 = "diaper"
/mob/living/carbon/var/brand3 = "plain"
/mob/living/carbon/var/heftersbonus = 0
/mob/living/carbon/var/needpee = 0
/mob/living/carbon/var/needpoo = 0
/mob/living/carbon/var/regressiontimer = 0
/mob/living/carbon/var/statusoverlay = null
/mob/var/rollbonus = 0

/mob/living/carbon/human/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/diaperswitch)

/mob/living/carbon/proc/Wetting()
	if (pee > 0 && stat != DEAD && src.client.prefs != "Poop Only")
		needpee = 0
		playsound(loc, 'sound/effects/pee-diaper.wav', 50, 1)
		if (istype(src.buckled,/obj/structure/potty) || istype(src.buckled,/obj/structure/toilet))
			if (istype(src.buckled,/obj/structure/potty))
				if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
					src.visible_message("<spawn class='notice'>[src] pulls [src.p_their()] pants down and pees in the potty like a big kid.</span>","<span class='notice'>You tug your pants down and pee in the potty like a big kid.</span>")
				if (max_wetcontinence < 100)
					max_wetcontinence++
			if (istype(src.buckled,/obj/structure/toilet))
				if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
					src.visible_message("<span class='notice'>[src] pulls [src.p_their()] pants down, and pees in the toilet.</span>","<span class='notice'>You pull your pants down, and pee in the toilet.</span>")
				if (max_wetcontinence < 100)
					max_wetcontinence++
		/*if (istype(src.buckled,/obj/structure/toilet))
			if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
				src.visible_message("<span class='notice'>[src] pulls [src.p_their()] pants down, and pees in the toilet.</span>","<span class='notice'>You pull your pants down, and pee in the toilet.</span>")
			if (max_wetcontinence < 100)
				max_wetcontinence++*/
		else
			if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
				if (on_purpose == 1) //pee on purpose
					switch(rand(2))
						if(0)
							src.visible_message("<span class='notice'>[src] scrunches [src.p_their()] legs and lets the floodgates open.</span>","<span class='notice'>You scrunch your legs and let the floodgates open.</span>")
						if(1)
							src.visible_message("<span class='notice'>[src] shifts [src.p_their()] stance and sighs, a soft hiss following.</span>","<span class='notice'>You spread your legs and sigh, releasing the pressure from your bladder into your awaiting diaper. </span>")
						else
							src.visible_message("<span class='notice'>[src] legs shift as [src.p_their()] crotch hisses.</span>","<span class='notice'>Spreading your legs softly, the contents of your bladder trickle out into your awaiting diaper.</span>")

				else
					switch(rand(2))	//pee accident
						if(0)
							src.visible_message("<span class='notice'>[src]'s legs buckle as [src.p_they()] [src.p_are()] unable to stop [src.p_their()] bladder from leaking into [src.p_their()] pants!</span>","<span class='notice'>Your legs buckle as you are unable to stop your bladder from leaking into your pants!</span>")
						if(1)
							src.visible_message("<span class='notice'>[src] freezes up as [src.p_their()] crotch hisses.</span>","<span class='notice'>You freeze up as the strain overwhelms your bladder, flooding your pants </span>")
						else
							src.visible_message("<span class='notice'>[src]'s legs buckle as [src.p_they()] [src.p_are()] unable to keep from wetting [src.p_their()] pants!</span>","<span class='notice'>Your legs buckle as you are unable to keep from wetting your pants!</span>")

			if(pee > max_wetcontinence)
				pee = max_wetcontinence
			if(wetness + pee < 250 + heftersbonus)
				wetness = wetness + pee
				pee = 0
			else
				wetness = 250 + heftersbonus
				new /obj/effect/decal/cleanable/waste/peepee(loc)
			if(max_wetcontinence > 10)
				max_wetcontinence--
		pee = 0
		on_purpose = 0
	else if (stat == DEAD)
		to_chat(src,"You can't pee, you're dead!")

/mob/living/carbon/proc/Pooping()
	if (poop > 0 && stat != DEAD && src.client.prefs != "Pee Only")
		needpoo = 0
		playsound(loc, 'sound/effects/uhoh.ogg', 50, 1)
		if (istype(src.buckled,/obj/structure/potty) || istype(src.buckled,/obj/structure/toilet))
			if (istype(src.buckled,/obj/structure/potty))
				if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
					src.visible_message("<spawn class='notice'>[src] pulls [src.p_their()] pants down and goes poopy in the potty like a big kid.</span>","<span class='notice'>You tug your pants down and go poopy in the potty like a big kid.</span>")
				if (max_messcontinence < 100)
					max_messcontinence++
			if (istype(src.buckled,/obj/structure/toilet))
				if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
					src.visible_message("<span class='notice'>[src] pulls [src.p_their()] pants down, and poops in the toilet.</span>","<span class='notice'>You pull your pants down, and poop in the toilet.</span>")
				if (max_messcontinence < 100)
					max_messcontinence++
		/*if (istype(src.buckled,/obj/structure/toilet))
			if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
				src.visible_message("<span class='notice'>[src] pulls [src.p_their()] pants down, and poops in the toilet.</span>","<span class='notice'>You pull your pants down, and poop in the toilet.</span>")
			if (max_messcontinence < 100)
				max_messcontinence++*/
		else
			if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
				if (on_purpose == 1)
					switch(rand(5)) //poop on purpose
						if(0)
							src.visible_message("<span class='notice'>An odor pervades the room as [src] dumps [src.p_their()] drawers.</span>","<span class='notice'>An odor pervades the room as you dump your drawers.</span>")
						if(1)
							src.visible_message("<span class='notice'>An odor pervades the room as [src] poops [src.p_their()] pants.</span>","<span class='notice'>An odor pervades the room as you poop your pants.</span>")
						if(2)
							src.visible_message("<span class='notice'>An odor pervades the room as [src] soils [src.p_their()] undergarmets.</span>","<span class='notice'>An odor pervades the room as you soil your undergarmets.</span>")
						if(3)
							src.visible_message("<span class='notice'>[usr] grabs [src.p_their()] midsection and squats, a foul scent quickly surrounding [src.p_them()].</span>","<span class='notice'>You wrap your arms around your tummy and bend your knees, pushing gently as the internal pressure subsides and your bottom grows warm.</span>")
						if(4)
							src.visible_message("<span class='notice'>[usr] seems to focus on something, and a foul odor is spreading.</span>","<span class='notice'>Hunching forward slightly, your face scrunches from effort as you slowly force the contents of your bowels into your diaper, expanding it backwards.</span>")
						else
							src.visible_message("<span class='notice'>[usr]'s cheeks flush as a foul stench surrounds [src.p_them()].</span>","<span class='notice'>Unable to cope with the pressure, you trust your underwear to protect your outfit as you let your bowels empty.</span>")
				else
					switch(rand(3))	//poop accident
						if(0)
							src.visible_message("<span class='notice'>[src] takes a squat and winces as [src.p_their()] seat sags just a little more.</span>","<span class='notice'>That tight feeling in your gut is gone. But your diaper seems a bit saggier- and stinkier.</span>")
						if(1)
							src.visible_message("<span class='notice'>[usr]'s bottom makes some rude noises, followed by a soft squishing sound.</span>","<span class='notice'>A burst of gas escapes your bottom, followed by another, and then something that definitely isn't gas.</span>")
						if(2)
							src.visible_message("<span class='notice'>You see [src] shiver slightly, and their diaper sags a noticable amount.</span>","<span class='notice'>You feel your diaper sag as you release the pressure from your backside</span>")
						else
							src.visible_message("<span class='notice'>You smell something unpleasant coming from [usr]'s direction. [src.p_they()] don't seem to notice, though.</span>","<span class='notice'>You feel an odd pressure in your stomach, before it quickly goes away.</span>")
			if(poop > max_messcontinence)
				poop = max_messcontinence
			if(stinkiness + poop < 250 + heftersbonus)
				stinkiness = stinkiness + poop
			else
				stinkiness = 250 + heftersbonus
			if(max_messcontinence > 10)
				max_messcontinence--
		on_purpose = 0
		poop = 0
	else if (stat == DEAD)
		to_chat(src,"You can't poop, you're dead!")

/mob/living/carbon/proc/PampUpdate()
	if(stat != DEAD && (HAS_TRAIT(src,TRAIT_INCONTINENT) || HAS_TRAIT(src,TRAIT_FULLYINCONTINENT) || HAS_TRAIT(src,TRAIT_POTTYREBEL) || HAS_TRAIT(src,BABYBRAINED_TRAIT) || HAS_TRAIT(src,TRAIT_DIAPERUSE)) && src.client != null)
		if(src.client.prefs.accident_types != "Poop Only")
			if (prob(25))
				pee = pee + 0.2
			else if (prob(25))
				pee = pee + 0.3
			else
				pee = pee + 0.25
		else
			pee = 0
		if(src.client.prefs.accident_types != "Pee Only")
			if (prob(25))
				poop = poop + 0.1
			else if (prob(25))
				poop = poop + 0.05
			else
				poop = poop + 0.075
		else
			poop = 0
	if(!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		if (wetness >= 1)
			if (HAS_TRAIT(src,TRAIT_POTTYREBEL))
				SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"peepee",/datum/mood_event/soggyhappy)
			else
				SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"peepee",/datum/mood_event/soggysad)
		else
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"peepee")
		if (stinkiness >= 1)
			if (HAS_TRAIT(src,TRAIT_POTTYREBEL))
				SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"poopy",/datum/mood_event/stinkyhappy)
			else
				SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"poopy",/datum/mood_event/stinkysad)
		else
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"poopy")
	if (fluids > 0)
		fluids = fluids - 10
	if (fluids < 0)
		fluids = 0
	if (pee >= max_wetcontinence * 0.5 && needpee <= 0 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		switch(rand(1))
			if(1)
				to_chat(src,"You start feeling the need to pee.")
			else
				to_chat(src,"You abdomen starts to feel tight and uncomfortable, you think about urinating.")
		needpee += 1
	if (pee >= max_wetcontinence * 0.8 && needpee <= 1 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		switch(rand(2))
			if(1)
				to_chat(src,"<span class='warning'>You really need to pee!</span>")
			if(2)
				to_chat(src,"<span class='warning'>Your body desperately fidgets and wriggles in an attempt to restrain your bladder a little bit longer...</span>")
			else
				to_chat(src,"<span class='warning'>You feel a squirt of pee escape!</span>")

		needpee += 1
	if (poop >= max_messcontinence * 0.5 && needpoo <= 0 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		switch(rand(5))
			if(1)
				to_chat(src,"You start feeling the need to poop.")
			if(2)
				to_chat(src,"Gas squeaks out, releasing a bit of pressure you didn't know you had.")
			if(3)
				to_chat(src,"You feel a soft gurgling from your tummy.")
			if(4)
				to_chat(src,"You feel your insides shift a bit")
			else
				to_chat(src,"You feel a slight pressure in your backside")
		needpoo += 1
	if (poop >= max_messcontinence * 0.8 && needpoo <= 1 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		switch(rand(4))
			if(1)
				to_chat(src,"<span class='warning'>You really need to poop!</span>")
			if(2)
				to_chat(src,"<span class='warning'>Your stomach gurgles and groans as a heavy weight descends into your bowels...</span>")
			if(3)
				to_chat(src,"<span class='warning'>You feel an immense pressure in your bowels!</span>")
			else
				to_chat(src,"<span class='warning'>You let out a fart that is dangerously wet!</span>")
		needpoo += 1
	if (pee >= max_wetcontinence && src.client.prefs != "Poop Only")
		Wetting()
	else if(pee >= max_wetcontinence)
		pee = 0
	if (poop >= max_messcontinence && src.client.prefs != "Pee Only")
		Pooping()
	else if(poop >= max_messcontinence)
		poop = 0
	switch(brand)
		if ("plain")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("classics")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("swaddles")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"sanshield",/datum/mood_event/sanitydiaper)
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("hefters_m")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("hefters_f")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Princess")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = TRUE
			rollbonus = 0
		if ("PwrGame")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 1
		if ("StarKist")
			set_light(3)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Space")
			set_light(0)
			ADD_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Replica")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
			adjustBruteLoss(-0.5)
		if ("Service")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Supply")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Hydroponics")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Sec")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Engineering")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Atmos")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Science")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Med")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Cult_Nar")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Cult_Clock")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Miner")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Miner_thick")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Ashwalker")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("alien")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
		if ("Jeans")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
			if (ishuman(src))
				var/mob/living/carbon/human/H = src
				var/datum/bank_account/D = H.get_bank_account()
				if (D)
					D.princessbonus = FALSE
			rollbonus = 0
	spawn(60)
	PampUpdate()

/mob/living/carbon/proc/DiaperAppearance()
	SEND_SIGNAL(src,COMSIG_DIAPERCHANGE, ckey(src.mind.key))

/mob/living/carbon/proc/DiaperChange(obj/item/diaper/diap)
	var/turf/cuckold = null
	var/newpamp
	switch(src.dir)
		if(1)
			cuckold = locate(src.loc.x + 1,src.loc.y,src.loc.z)
		if(2)
			cuckold = locate(src.loc.x - 1,src.loc.y,src.loc.z)
		if(4)
			cuckold = locate(src.loc.x,src.loc.y - 1,src.loc.z)
		if(8)
			cuckold = locate(src.loc.x,src.loc.y + 1,src.loc.z)
	if (wetness >= 1)
		if(brand3 == "syndi")
			brand3 = "plain"
		if (stinkiness >= 1)
			newpamp = text2path(addtext("/obj/item/useddiap/", brand3))
		else
			newpamp = text2path(addtext("/obj/item/wetdiap/", brand3))
	else
		if (stinkiness >= 1)
			if(brand3 == "syndi")
				brand3 = "plain"
			newpamp = text2path(addtext("/obj/item/poopydiap/", brand3))
		else
			newpamp = text2path(addtext("/obj/item/diaper/", brand3))
	new newpamp(cuckold)
	wetness = 0
	stinkiness = 0
	brand3 = replacetext("[diap]", "/obj/item/diaper/", "")
	if(HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"peepee")
		SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"poopy")

/mob/living/carbon/verb/Pee()
	if(usr.client.prefs.accident_types != "Poop Only")
		set category = "IC"
	if((HAS_TRAIT(usr,TRAIT_INCONTINENT) || HAS_TRAIT(usr,TRAIT_POTTYREBEL) || HAS_TRAIT(usr,BABYBRAINED_TRAIT) || HAS_TRAIT(usr,TRAIT_DIAPERUSE)) && !HAS_TRAIT(usr,TRAIT_FULLYINCONTINENT) && pee >= max_wetcontinence/2)
		on_purpose = 1
		Wetting()
	else
		to_chat(usr, "<span class='warning'>You cannot pee right now.</span>")

/mob/living/carbon/verb/Poop()
	if(usr.client.prefs.accident_types != "Pee Only")
		set category = "IC"
	if((HAS_TRAIT(usr,TRAIT_INCONTINENT) || HAS_TRAIT(usr,TRAIT_POTTYREBEL) || HAS_TRAIT(usr,BABYBRAINED_TRAIT) || HAS_TRAIT(usr,TRAIT_DIAPERUSE)) && !HAS_TRAIT(usr,TRAIT_FULLYINCONTINENT) && poop >= max_messcontinence/2)
		on_purpose = 1
		Pooping()
	else
		to_chat(usr, "<span class='warning'>You cannot poop right now.</span>")

/mob/living/carbon/New()
	..()
	PampUpdate()

/obj/item/reagent_containers/food/snacks/attack(mob/living/carbon/human/M, mob/living/user, def_zone)
	..()
	if(M.client.prefs.accident_types != "Pee Only")
		M.poop = M.poop + 1

/obj/item/reagent_containers/food/drinks/attack(mob/living/carbon/human/M, mob/living/user, def_zone)
	..()
	if(M.client.prefs.accident_types != "Poop Only")
		M.pee = M.pee + 2
	M.fluids = M.fluids + 25
	if (M.fluids > 300)
		M.fluids = 300

/atom/movable/screen/diaperstatus
	name = "diaper state"
	icon = 'icons/incon/diapercondition.dmi'
	icon_state = "hud_plain"
	screen_loc = ui_diaper

/atom/movable/screen/diaperstatus/proc/DiaperUpdate(mob/living/carbon/owner)
	if(HAS_TRAIT(owner,BABYBRAINED_TRAIT))
		if(owner.regressiontimer > 0)
			owner.regressiontimer--
		else if(owner.reagents.has_reagent(/datum/reagent/medicine/regression))
			owner.regressiontimer = 0
		else
			REMOVE_TRAIT(owner,BABYBRAINED_TRAIT,REGRESSION_TRAIT)
			REMOVE_TRAIT(owner,TRAIT_NORUNNING,REGRESSION_TRAIT)
			REMOVE_TRAIT(owner,TRAIT_NOGUNS,REGRESSION_TRAIT)
			SEND_SIGNAL(owner,COMSIG_DIAPERCHANGE,owner.ckey)
	if((HAS_TRAIT(owner,TRAIT_POTTYREBEL) || HAS_TRAIT(owner,TRAIT_INCONTINENT) || HAS_TRAIT(owner,BABYBRAINED_TRAIT) || HAS_TRAIT(owner,TRAIT_DIAPERUSE)) && !HAS_TRAIT(owner,TRAIT_FULLYINCONTINENT))
		if (owner.wetness > 0)
			if (owner.stinkiness > 0)
				icon_state = "hud_plain_used"
			else
				icon_state = "hud_plain_wet"
		else
			if (owner.stinkiness > 0)
				icon_state = "hud_plain_poopy"
			else
				icon_state = "hud_plain"
	else
		icon_state = null
	if(owner.brand == "Science")
		SSresearch.science_tech.add_point_type(TECHWEB_POINT_TYPE_GENERIC, 0.25)
	if(owner.brand == "alien")
		owner.wetness -= 0.1
		owner.stinkiness -= 0.1
	spawn(1)
	DiaperUpdate(owner)

/atom/movable/screen/diaperstatus/New(mob/living/carbon/owner)
	DiaperUpdate(owner)


/datum/hud/human/New(mob/living/carbon/owner)
	..()
	var/atom/movable/screen/diapstats = new /atom/movable/screen/diaperstatus(owner)
	if (HAS_TRAIT(owner,TRAIT_INCONTINENT))
		owner.max_wetcontinence = 50
		owner.max_messcontinence = 50
	else
		owner.max_wetcontinence = 100
		owner.max_messcontinence = 100
	diapstats.hud = src
	infodisplay += diapstats

/obj/effect/decal/cleanable/waste
	icon = 'icons/incon/accidents.dmi'
	gender = NEUTER

/obj/effect/decal/cleanable/waste/peepee
	name = "urine"
	desc = "A puddle of urine. Looks like we have a leaker."
	icon_state = "peepee"
	persistent = FALSE

/obj/effect/decal/cleanable/waste/peepee/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	AddComponent(/datum/component/slippery, 80, (NO_SLIP_WHEN_WALKING | SLIDE))

/datum/mood_event/soggysad
	description = "<span class='warning'>Aw man, my pants are wet...\n</span>"
	mood_change = -3

/datum/mood_event/soggyhappy
	description = "<span class='nicegreen'>A wet diaper is always comfy!\n</span>"
	mood_change = 3

/datum/mood_event/stinkysad
	description = "<span class='warning'>Ew... I need a change.\n</span>"
	mood_change = -5

/datum/mood_event/stinkyhappy
	description = "<span class='nicegreen'>Heh, take that, potty!\n</span>"
	mood_change = 5

/datum/mood_event/sanitydiaper
	description = "<span class='nicegreen'>I can't describe it- this diaper makes me feel safe!\n</span>"
	mood_change = 20
