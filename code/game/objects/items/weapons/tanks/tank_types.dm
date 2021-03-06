/* Types of tanks!
 * Contains:
 *		Oxygen
 *		Anesthetic
 *		Air
 *		Phoron
 *		Emergency Oxygen
 */

/*
 * Oxygen
 */
/obj/item/weapon/tank/oxygen
	name = "oxygen tank"
	desc = "A tank of oxygen."
	icon_state = REAGENT_ID_OXYGEN
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD


	New()
		..()
		air_contents.adjust_gas(REAGENT_ID_OXYGEN, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))
		return


	examine(mob/user)
		if(..(user, 0) && air_contents.gas[REAGENT_ID_OXYGEN] < 10)
			user << text("<span class='warning'>The meter on \the [src] indicates you are almost out of oxygen!</span>")
			//playsound(usr, 'sound/effects/alert.ogg', 50, 1)


/obj/item/weapon/tank/oxygen/yellow
	desc = "A tank of oxygen, this one is yellow."
	icon_state = "oxygen_f"

/obj/item/weapon/tank/oxygen/red
	desc = "A tank of oxygen, this one is red."
	icon_state = "oxygen_fr"


/*
 * Anesthetic
 */
/obj/item/weapon/tank/anesthetic
	name = "anesthetic tank"
	desc = "A tank with an N2O/O2 gas mix."
	icon_state = "anesthetic"
	item_state = "an_tank"

/obj/item/weapon/tank/anesthetic/New()
	..()

	air_contents.gas[REAGENT_ID_OXYGEN] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gas[REAGENT_ID_N2O] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
	air_contents.update_values()

	return

/*
 * Air
 */
/obj/item/weapon/tank/air
	name = "air tank"
	desc = "Mixed anyone?"
	icon_state = REAGENT_ID_OXYGEN


	examine(mob/user)
		if(..(user, 0) && air_contents.gas[REAGENT_ID_OXYGEN] < 1 && loc==user)
			user << "<span class='danger'>The meter on the [src.name] indicates you are almost out of air!</span>"
			user << sound('sound/effects/alert.ogg')

/obj/item/weapon/tank/air/New()
	..()

	src.air_contents.adjust_multi(REAGENT_ID_OXYGEN, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD, REAGENT_ID_NITROGEN, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD)

	return


/*
 * Phoron
 */
/obj/item/weapon/tank/phoron
	name = "fuel tank"
	desc = "Contains dangerous fuel. Do not inhale. Warning: extremely flammable."
	icon_state = "phoron"
	gauge_icon = null
	flags = CONDUCT
	slot_flags = null	//they have no straps!


/obj/item/weapon/tank/phoron/New()
	..()

	src.air_contents.adjust_gas(REAGENT_ID_FUEL, (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))
	return

/obj/item/weapon/tank/phoron/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()

	if (istype(W, /obj/item/weapon/flamethrower))
		var/obj/item/weapon/flamethrower/F = W
		if ((!F.status)||(F.ptank))	return
		src.master = F
		F.ptank = src
		user.remove_from_mob(src)
		src.loc = F
	return

/*
 * Emergency Oxygen
 */
/obj/item/weapon/tank/emergency_oxygen
	name = "emergency oxygen tank"
	desc = "Used for emergencies. Contains very little oxygen, so try to conserve it until you actually need it."
	icon_state = "emergency"
	gauge_icon = "indicator_emergency"
	gauge_cap = 4
	flags = CONDUCT
	slot_flags = SLOT_BELT
	w_class = 2.0
	force = 4.0
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 2 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)


	New()
		..()
		src.air_contents.adjust_gas(REAGENT_ID_OXYGEN, (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

		return


	examine(mob/user)
		if(..(user, 0) && air_contents.gas[REAGENT_ID_OXYGEN] < 0.2 && loc==user)
			user << text("<span class='danger'>The meter on the [src.name] indicates you are almost out of air!</span>")
			user << sound('sound/effects/alert.ogg')

/obj/item/weapon/tank/emergency_oxygen/engi
	name = "extended-capacity emergency oxygen tank"
	icon_state = "emergency_engi"
	volume = 6

/obj/item/weapon/tank/emergency_oxygen/double
	name = "double emergency oxygen tank"
	icon_state = "emergency_double"
	gauge_icon = "indicator_emergency_double"
	volume = 10

/obj/item/weapon/tank/emergency_nitrogen
	name = "emergency nitrogen tank"
	desc = "An emergency air tank hastily painted red and issued to Vox crewmembers."
	icon_state = "emergency_nitro"
	gauge_icon = "indicator_emergency"
	gauge_cap = 4
	flags = CONDUCT
	slot_flags = SLOT_BELT
	w_class = 2.0
	force = 4.0
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 2

	New()
		..()
		src.air_contents.adjust_gas(REAGENT_ID_NITROGEN, (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

		return


	examine(mob/user)
		if(..(user, 0) && air_contents.gas[REAGENT_ID_NITROGEN] < 0.2 && loc==user)
			user << text("<span class='danger'>The meter on \the [src] indicates you are almost out of air!</span>")
			user << sound('sound/effects/alert.ogg')

/*
 * Nitrogen
 */
/obj/item/weapon/tank/nitrogen
	name = "nitrogen tank"
	desc = "A tank of nitrogen."
	icon_state = "oxygen_fr"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD


/obj/item/weapon/tank/nitrogen/New()
	..()

	src.air_contents.adjust_gas(REAGENT_ID_NITROGEN, (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))
	return

/obj/item/weapon/tank/nitrogen/examine(mob/user)
	if(..(user, 0) && air_contents.gas[REAGENT_ID_NITROGEN] < 10)
		user << text("<span class='danger'>The meter on \the [src] indicates you are almost out of nitrogen!</span>")
		//playsound(user, 'sound/effects/alert.ogg', 50, 1)
