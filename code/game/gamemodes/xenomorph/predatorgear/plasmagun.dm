/****************************** PLASMA GUN *******************************/

/obj/item/weapon/predatortank
	name = "plasma tank"
	desc = "A military-grade tank of pure plasma used to execute excessively dangerous blasts."
	slot_flags = SLOT_BACK
	var/obj/item/weapon/gun/energy/predator/P
	w_class = 5
	force = 10
	actions_types = list(/datum/action/item_action/toggleyautijatank)

/datum/action/item_action/toggleyautijatank
	name = "Toggle Plasma Gun"
	button_icon_state = "predgun-on"

/obj/item/weapon/predatortank/New()
	..()
	P = new(src)

/obj/item/weapon/predatortank/attack_self(mob/user)
	if(P)
		if(P.loc != src)
			if(istype(user, /mob/living/carbon/human))
				if(user.get_active_hand() == P)
					user << "<span class='warning'>You return [P] into [src].</span>"
					user.unEquip(P, 1)
					P.forceMove(src)
					P.selfcharge = TRUE
					for(var/datum/action/item_action/toggleyautijatank/TYT in actions)
						TYT.button_icon_state = "predgun-on"
						TYT.UpdateButtonIcon()
		else
			var/mob/living/carbon/human/H = user
			var/returned
			if(!H.r_hand)
				H.put_in_r_hand(P)
				P.selfcharge = FALSE
				returned = TRUE
			else if (!H.l_hand)
				H.put_in_l_hand(P)
				P.selfcharge = FALSE
				returned = TRUE
			else
				H << "<span class='warning'>You have something in your hand right now.</span>"
			if(returned)
				for(var/datum/action/item_action/toggleyautijatank/TYT in actions)
					TYT.button_icon_state = "predgun-off"
					TYT.UpdateButtonIcon()
	else
		user << "<span class='warning'>Your plasma tank is missing it's gun...</span>"

/obj/item/weapon/gun/energy/predator
	name = "plasma gun"
	desc = "A military-grade plasma gun that shoots intensly large plasma bolts. However it drains fast. It's connected to a plasma tank that does the job at refueling the blaster whenever it's holestered."
	icon_state = "plasmacaster"
	item_state = "plasmacaster"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/predator)
	ammo_x_offset = 1
	force = 12
	w_class = 5

/obj/item/weapon/gun/energy/predator/New()
	..()
	flags |= NODROP