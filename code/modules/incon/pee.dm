/mob/living/proc/generate_pee(datum/reagents/R, owner, atom/target, spill = TRUE)
	var/mob/living/carbon/human/H = owner
	var/datum/reagent/fluid_id = null
	// 10 is the minimum amount for us to generate a decal, so we use that
	// H.get_blood_data() is required to get the owner's DNA put into the puddle
	R.add_reagent(fluid_id, 10, H.get_blood_data())
	return TRUE
