
PROCESSING_SUBSYSTEM_DEF(specials)
	name = "Specials"
	flags = SS_BACKGROUND
	priority = 20

	/// Dictionary of special types
	var/list/specials_weighted = list()
	/// Dictionary of primordials (singletons but not really)
	var/list/special_primordials = list()

/datum/controller/subsystem/processing/specials/Initialize(start_timeofday)
	. = ..()

	var/datum/special/S // something something put it infront of the loop
	for(var/special as anything in subtypesof(/datum/special))
		S = new special()
		special_primordials[special] = S
		specials_weighted[special] = S.weight

/// Returns a random WEIGHTED special pick
/datum/controller/subsystem/processing/specials/proc/pick_special()
	return pickweight(specials_weighted)

/// Try to apply a special to the specified human
/datum/controller/subsystem/processing/specials/proc/try_apply_special(mob/living/carbon/human/H, special_type)
	var/datum/special/special = special_primordials[special_type]
	if(!special || !special.check_requirements(H))
		return FALSE

	special = new special_type()
	special.owner = H
	H.special = special
	special.on_applied(H)
	START_PROCESSING(SSspecials, special)

	return TRUE

