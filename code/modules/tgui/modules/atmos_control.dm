/datum/tgui_module_old/atmos_control
	name = "Atmospherics Control"
	tgui_id = "AtmosControl"
	var/obj/access = new()
	var/emagged = 0
	var/ui_ref
	var/list/monitored_alarms = list()

/datum/tgui_module_old/atmos_control/New(atmos_computer, req_access, req_one_access, monitored_alarm_ids)
	..()
	access.req_access = req_access
	access.req_one_access = req_one_access

	if(monitored_alarm_ids)
		for(var/obj/machinery/alarm/alarm in GLOB.machines)
			if(alarm.alarm_id && (alarm.alarm_id in monitored_alarm_ids))
				monitored_alarms += alarm
		// machines may not yet be ordered at this point
		monitored_alarms = dd_sortedObjectList(monitored_alarms)

/datum/tgui_module_old/atmos_control/ui_act(action, params, datum/tgui/ui)
	if(..())
		return TRUE

	switch(action)
		if("alarm")
			if(ui_ref)
				var/obj/machinery/alarm/alarm = locate(params["alarm"]) in (monitored_alarms.len ? monitored_alarms : GLOB.machines)
				if(alarm)
					var/datum/ui_state/TS = generate_state(alarm)
					alarm.ui_interact(usr, parent_ui = ui_ref, state = TS)
			return 1

/datum/tgui_module_old/atmos_control/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/nanomaps),
	)

/datum/tgui_module_old/atmos_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id, name)
		ui.autoupdate = TRUE
		ui.open()
	ui_ref = ui

/datum/tgui_module_old/atmos_control/ui_static_data(mob/user)
	. = ..()

	var/z = get_z(user)
	var/list/map_levels = (LEGACY_MAP_DATUM).get_map_levels(z)

	// TODO: Move these to a cache, similar to cameras
	var/alarms[0]
	for(var/obj/machinery/alarm/alarm in (monitored_alarms.len ? monitored_alarms : GLOB.machines))
		if(!monitored_alarms.len && alarm.alarms_hidden)
			continue
		if(!(alarm.z in map_levels))
			continue
		alarms[++alarms.len] = list(
			"name" = sanitize(alarm.name),
			"ref"= "\ref[alarm]",
			"danger" = max(alarm.danger_level, alarm.alarm_area.atmosalm),
			"x" = alarm.x,
			"y" = alarm.y,
			"z" = alarm.z)
	.["alarms"] = alarms

/datum/tgui_module_old/atmos_control/ui_data(mob/user)
	var/list/data = list()

	var/z = get_z(user)
	var/list/map_levels = (LEGACY_MAP_DATUM).get_map_levels(z)
	data["map_levels"] = map_levels

	return data

/datum/tgui_module_old/atmos_control/ui_close()
	. = ..()
	ui_ref = null

/datum/tgui_module_old/atmos_control/proc/generate_state(air_alarm)
	var/datum/ui_state/air_alarm_remote/state = new()
	state.atmos_control = src
	state.air_alarm = air_alarm
	return state

/datum/ui_state/air_alarm_remote
	var/datum/tgui_module_old/atmos_control/atmos_control = null
	var/obj/machinery/alarm/air_alarm = null

/datum/ui_state/air_alarm_remote/can_use_topic(src_object, mob/user)
	if(!atmos_control.ui_ref)
		qdel(src)
		return UI_CLOSE
	if(has_access(user))
		return UI_INTERACTIVE
	return UI_UPDATE

/datum/ui_state/air_alarm_remote/proc/has_access(mob/user)
	return user && (isAI(user) || atmos_control.access.allowed(user) || atmos_control.emagged || air_alarm.rcon_setting == (RCON_YES || RCON_AUTO) || (air_alarm.alarm_area.atmosalm && air_alarm.rcon_setting == RCON_AUTO) || (ACCESS_ENGINEERING_ATMOS in user.GetAccess()))

/datum/ui_state/air_alarm_remote/Destroy()
	atmos_control = null
	air_alarm = null
	return ..()

/datum/tgui_module_old/atmos_control/ntos
	ntos = TRUE

/datum/tgui_module_old/atmos_control/robot
/datum/tgui_module_old/atmos_control/robot/ui_state(mob/user, datum/tgui_module/module)
	return GLOB.self_state
