/datum/role/job/station/lawyer
	id = JOB_ID_LAWYER
	title = "Internal Affairs Agent"
	flag = LAWYER
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	total_positions = 2
	spawn_positions = 2
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#515151"
	idtype = /obj/item/card/id/civilian/internal_affairs_agent
	minimal_access = list(
		ACCESS_COMMAND_IAA,
		ACCESS_SECURITY_MAIN,
		ACCESS_COMMAND_BRIDGE,
	)
	minimal_player_age = 7

	outfit_type = /datum/outfit/job/station/internal_affairs_agent
	alt_titles = list("Regulatory Affairs Agent" = /datum/prototype/struct/alt_title/iaa/regulator)
	desc = "An Internal Affairs Agent makes sure that the crew is following Standard Operating Procedure. They also \
						handle complaints against crew members, and can have issues brought to the attention of Central Command, \
						assuming their paperwork is in order."

/datum/prototype/struct/alt_title/iaa/regulator
	title = "Regulatory Affairs Agent"

/*
/datum/role/job/station/lawyer/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)
*/

/datum/outfit/job/station/internal_affairs_agent
	name = OUTFIT_JOB_NAME("Internal affairs agent")
	l_ear = /obj/item/radio/headset/ia
	uniform = /obj/item/clothing/under/rank/internalaffairs
	suit = /obj/item/clothing/suit/storage/toggle/internalaffairs
	shoes = /obj/item/clothing/shoes/brown
	glasses = /obj/item/clothing/glasses/sunglasses/big
	l_hand = /obj/item/clipboard
	id_type = /obj/item/card/id/civilian/internal_affairs_agent
	pda_type = /obj/item/pda/lawyer
