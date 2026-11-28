/datum/special
	/// Self explanatory
	var/name = "/datum/special"
	/// What our player will know about this special
	var/description = "If you see this you are indeed very special."
	/// Requirement string
	var/reguirement = ""
	/// The weight of this special
	var/weight = 1
	/// The mob this special belongs to
	var/mob/owner

/// Check if special can be applied
/datum/special/proc/check_requirements(mob/living/carbon/human/H)
	return TRUE

/// Called once the special is applied to the mob
/datum/special/proc/on_applied(mob/living/carbon/human/H)

/// Called once the special is removed from the mob
/datum/special/proc/on_removed(mob/living/carbon/human/H)

/// Called every second if we have a mob
/datum/special/proc/process_special(mob/living/carbon/human/H)

/datum/special/process()
	if(!owner || !ishuman(owner))
		return PROCESS_KILL

	return process_special(owner)

/datum/special/proc/get_description()
	return description

// debug verb TODO: REMOVE THIS
/mob/new_player/verb/pick_special()
	client.pref.picked_special = SSspecials.pick_special()
	var/datum/special/S = SSspecials[client.pref.picked_special] // need to do this for spacemandmm to shut up
	to_chat(user, "<span><b>Your character is now special!</b><br>[S.get_description()]</span>")
