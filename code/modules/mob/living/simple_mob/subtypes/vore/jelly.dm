/datum/category_item/catalogue/fauna/jelly
	name = "Jelly Blob"
	desc = "These curious creatures are native to the caustic surface of Virgo 2. \
	Although docile, their undulating bodies can sometimes get in the way of attacks \
	meant for more dangerous fauna. When struck, jelly blobs react violently, although \
	their soft exterior does not lend itself well to combat."
	value = CATALOGUER_REWARD_TRIVIAL

/mob/living/simple_mob/animal/space/jelly
	name = "jelly blob"
	desc = "Some sort of undulating blob of slime!"
	catalogue_data = list(/datum/category_item/catalogue/fauna/jelly)

	icon_dead = "jelly_dead"
	icon_living = "jelly"
	icon_state = "jelly"
	icon = 'icons/mob/vore.dmi'

	faction = "virgo2"
	maxHealth = 50
	health = 50

	melee_damage_lower = 2
	melee_damage_upper = 7

	response_help = "gently pets"
	response_disarm = "tries to shove"
	response_harm = "mushes their hand into"

	say_list_type = /datum/say_list/jelly
	ai_holder_type = /datum/ai_holder/simple_mob/retaliate/jelly

//Randomization Code
/mob/living/simple_mob/animal/space/jelly/Initialize()
    . = ..()
    var/mod = rand(mod_min,mod_max)/100
    size_multiplier = mod
    maxHealth = round(maxHealth*mod)
    health = round(health*mod)
    melee_damage_lower = round(melee_damage_lower*mod)
    melee_damage_upper = round(melee_damage_upper*mod)
    movement_cooldown = round(movement_cooldown*mod)
    meat_amount = round(meat_amount*mod)
    update_icons()


// Activate Noms!
/mob/living/simple_mob/animal/space/jelly
	vore_active = 1
	vore_pounce_chance = 0
	vore_icons = SA_ICON_LIVING
	swallowTime = 2 SECONDS // Hungry little bastards.

/datum/say_list/jelly
	emote_hear = list("squishes","spluts","splorts","sqrshes","makes slime noises")
	emote_see = list("undulates quietly")

/datum/ai_holder/simple_mob/retaliate/jelly
	speak_chance = 2

// Talon's Pet, Wiggleblob!
/mob/living/simple_mob/animal/space/jelly/wiggleblob
	name = "Mr. Wiggleblob."
	desc = "Mr. Wiggleblob! The official mascot of the Talon. So huggable. So squishable. Just try not to get eaten!"
	makes_dirt = FALSE

//Unrandom the pet
/mob/living/simple_mob/animal/space/jelly/wiggleblob/Initialize()
    . = ..()
    size_multiplier = 1
    maxHealth = maxHealth
    health = health
    melee_damage_lower = melee_damage_lower
    melee_damage_upper = melee_damage_upper
    movement_cooldown = movement_cooldown
    meat_amount = meat_amount
    update_icons()
