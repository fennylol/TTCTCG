extends Node3D
class_name PackZoneNode

@onready var UI: PackUINode = $PackUI

signal starting
signal finished
signal pack_pull_results(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card])

const STARTING_PACK_HEIGHT: float = 5.0
# =============== #
# signal emission #
# =============== #
func _start() -> void:
	COLLECTION._update_pack_timers()
	starting.emit()
	UI._update_timer_charge_count()
	UI.set_visible(false)
# ================ #
# signal reception #
# ================ #
func _on_visibility_changed()      -> void: UI.set_visible(visible)
func _on_ui_back_button_pressed()  -> void: finished.emit()
func _on_ui_store_button_pressed() -> void: 
	if COLLECTION.next_pack_timestamp < Time.get_unix_time_from_system():
		COLLECTION._recieve_timer_charges(12)
		COLLECTION._update_pack_timers()
		UI._update_timer_charge_count()
	else:
		var time_str: String = Time.get_time_string_from_unix_time(int(COLLECTION.next_pack_timestamp-Time.get_unix_time_from_system()))
		LOGGER.log_msg("please wait " + time_str, LOGGER.Flags.TOAST)


func _on_ui_expansion_selected(ExpansionID: DATA.ExpansionIDs, SinglePack: bool) -> void:
	if SinglePack:
		if COLLECTION.next_pack_timestamp < Time.get_unix_time_from_system(): 
			pull_single_pack(ExpansionID)
		else:
			var time_diff: float = COLLECTION.next_pack_timestamp - Time.get_unix_time_from_system()
			var needed_charges: int = ceil(time_diff/COLLECTION.TIMER_CHARGE_VALUE)
			
			if needed_charges <= COLLECTION.timer_charges:
				var popup = PopUpConfirm.new("spend " + str(needed_charges) + " timer charges to refill pack bar?\n" + "you currently own " + str(COLLECTION.timer_charges))
				popup.confirm.connect(func():
					COLLECTION._spend_timer_charges(needed_charges)
					pull_single_pack(ExpansionID)
				)
				LOGGER.post_msg_board_node(popup)
				await popup.tree_exiting
			else:
				var msg: String = str(needed_charges) + " timer charges are needed to refill pack bar.\n" + "you currently own " + str(COLLECTION.timer_charges)
				LOGGER.post_msg_board_message(msg, 5)

	else:
		var value_in_packs   : int   = 10
		var time_diff        : float = max(max(COLLECTION.next_pack_timestamp+COLLECTION.NEXT_PACK_UNIX_TIME_OFFSET,COLLECTION.next_pack_timestamp)-Time.get_unix_time_from_system(), 0)
		var price_in_seconds : float = (COLLECTION.NEXT_PACK_UNIX_TIME_OFFSET * (value_in_packs-2)) + time_diff
		var needed_charges   : int   = ceil(price_in_seconds/COLLECTION.TIMER_CHARGE_VALUE)
		
		if needed_charges <= COLLECTION.timer_charges:
			var popup = PopUpConfirm.new("spend " + str(needed_charges) + " timer charges to refill pack bar?\n" + "you currently own " + str(COLLECTION.timer_charges))
			popup.confirm.connect(func():
				COLLECTION._spend_timer_charges(needed_charges)
				pull_booster_box(ExpansionID)
			)
			LOGGER.post_msg_board_node(popup)
			await popup.tree_exiting
		else:
			var msg: String = str(needed_charges) + " timer charges are needed to refill pack bar.\n" + "you currently own " + str(COLLECTION.timer_charges)
			LOGGER.post_msg_board_message(msg, 5)

func pull_single_pack(ExpansionID: DATA.ExpansionIDs) -> void:
	_start()
	
	var pull        : Dictionary    = determine_pack_pull(ExpansionID)
	var pack_rarity : DATA.Rarities = pull["RARITY"]
	var pack_content: Array[Card]   = pull["CONTENT"] 
	
	LOGGER.log_msg("pack_zone.gd - pull_single_pack(): generated a " + DATA.Rarities.find_key(pack_rarity) + " pack from " + DATA.ExpansionIDs.find_key(ExpansionID))
	pack_pull_results.emit(ExpansionID, pack_content)
	
	var pack: Pack = Pack.new(pack_rarity, pack_content)
	pack.set_name(DATA.Rarities.find_key(pack_rarity).to_lower()+"_pack_"+str(int(RNG.random_value()*1000)))
	pack.finished.connect(finished.emit)
	add_child(pack)


func pull_booster_box(ExpansionID: DATA.ExpansionIDs):
	var packs  : Array[Pack] = []
	var results: Array[Card] = []
	var counts : Array[int]  = [0,0,0]
	
	while counts[DATA.ContentTypes.CRITTER]    < 5 and \
		  counts[DATA.ContentTypes.CONSUMABLE] < 5 and \
		  counts[DATA.ContentTypes.WEAPON]     < 5:
		var pull        : Dictionary    = determine_pack_pull(ExpansionID)
		var pack_rarity : DATA.Rarities = pull["RARITY"]
		var pack_content: Array[Card]   = pull["CONTENT"] 
		
		for i in range(pack_content.size()): if not i%2: counts[pack_content[i].Type]+=1
		
		results.append_array(pack_content)
		LOGGER.log_msg("pack_zone.gd - pull_booster_box(): generated a " + DATA.Rarities.find_key(pack_rarity) + " pack from " + DATA.ExpansionIDs.find_key(ExpansionID))
		
		var pack: Pack = Pack.new(pack_rarity, pack_content)
		pack.set_name(DATA.Rarities.find_key(pack_rarity).to_lower()+"_pack_"+str(int(RNG.random_value()*1000)))
		packs.append(pack)
	
	pack_pull_results.emit(ExpansionID, results)
	while packs.size():
		var pack: Pack = packs.pop_front()
		add_child(pack)
		if not packs.size(): pack.finished.connect(finished.emit)
		else: await pack.finished

# ================ #
# internal utility #
# ================ #
func enter_pack_zone() -> void: UI._update_timer_charge_count()
func determine_pack_pull(ExpansionID : DATA.ExpansionIDs) -> Dictionary:
	var pack_rarity     : DATA.Rarities        = determine_pack_rarity(ExpansionID)
	var content_rarities: Array[DATA.Rarities] = determine_pack_content_rarities(ExpansionID, pack_rarity)
	var partner_rarities: Array[DATA.Rarities] = determine_pack_content_rarities(ExpansionID, pack_rarity, false)
	var content         : Array[Card]          = determine_pack_contents(ExpansionID, content_rarities, partner_rarities)
	return {"RARITY":pack_rarity, "CONTENT":content}
func determine_pack_rarity(ExpansionID : DATA.ExpansionIDs) -> DATA.Rarities:
	var pack_rarity_odds: Array[float] = DATA.get_pack_rarity_odds(ExpansionID)
	var thresh = RNG.random_value()
	
	for r in DATA.Rarities:
		thresh -= pack_rarity_odds[DATA.Rarities[r]]
		if thresh <= 0: return DATA.Rarities[r]
	
	@warning_ignore("int_as_enum_without_match")
	return -1 as DATA.Rarities
func determine_pack_content_rarities(ExpansionID : DATA.ExpansionIDs, PackRarity : DATA.Rarities, Sorted : bool = true) -> Array[DATA.Rarities]:
	var content_rarity_odds: Array[float] = DATA.get_content_rarity_odds(ExpansionID, PackRarity)
	var content_count: int = DATA.get_pack_content_count(ExpansionID, PackRarity)
	
	var rarities: Array[DATA.Rarities] = []
	for i in content_count:
		var thresh = RNG.random_value()
		for r in DATA.Rarities:
			thresh -= content_rarity_odds[DATA.Rarities[r]]
			if thresh <= 0: 
				rarities.append(DATA.Rarities[r])
				break
	
	if Sorted: rarities.sort()
	return rarities
func determine_pack_contents(ExpansionID : DATA.ExpansionIDs, ContentRarities : Array[DATA.Rarities], PartnerRarities : Array[DATA.Rarities]) -> Array[Card]:
	var cards: Array[Card] = []
	
	for i in ContentRarities.size():
		var rarity = ContentRarities[i]
		var partner_rarity = PartnerRarities[i]
		var type: DATA.ContentTypes = floor(DATA.ContentTypes.size() * RNG.random_value())
		
		var type_rarity_count: int = DATA.get_expansion_content_count(ExpansionID, rarity, type)
		var partner_type_rarity_count: int = DATA.get_expansion_content_count(ExpansionID, partner_rarity, type)
		
		var idx = floor(type_rarity_count * RNG.random_value())
		var partner_idx = floor(partner_type_rarity_count * RNG.random_value())
		
		#var pair = DATA.get_paired_expansion_content(ExpansionID, rarity, type, idx, ExpansionID, partner_rarity, type, partner_idx)
		var card: Card = DATA.get_expansion_content(ExpansionID, rarity, type, idx)
		var partner_card: Card = DATA.get_expansion_content(ExpansionID, partner_rarity, type, partner_idx)
		
		#cards.append(pair)
		cards.append(card)
		cards.append(partner_card)
	
	return cards


func DEBUG_roll_pack_odds(ExpansionID: DATA.ExpansionIDs, num_trials: int = 100) -> Array[int]:
	var counts: Array[int] = [0,0,0,0,0,0]
	for i in range(num_trials):
		var pack_rarity = determine_pack_rarity(ExpansionID)
		var card_rarities = determine_pack_content_rarities(ExpansionID, pack_rarity)
		for rarity in card_rarities:
			counts[rarity]+=1
	
	var count_ev: float = 0.0
	for rarity in DATA.Rarities: count_ev += DATA.get_pack_content_count(ExpansionID, DATA.Rarities[rarity])*DATA.get_pack_rarity_odds(ExpansionID)[DATA.Rarities[rarity]]
	
	var total_cards : int = DATA.array_sum_i(counts)
	var prop_EVs : Array[float] = DATA.calculate_expected_card_proportions_per_pack(ExpansionID)
	LOGGER.log_msg("RESULTS FOR " + str(num_trials) + " \"PACKS\" OF " + DATA.ExpansionIDs.find_key(ExpansionID))
	LOGGER.log_msg("total cards:\t", total_cards)
	LOGGER.log_msg("per pack:\t\t" + str(snappedf(float(total_cards)/float(num_trials), 0.001)) + "\t\t" + str(count_ev))
	
	LOGGER.log_msg("rarity\t\t|\tcount\t|\tprop\t|\tEV\t\t|\tdiff")
	for rarity in DATA.Rarities:
		var count = counts[DATA.Rarities[rarity]]
		var prop = float(count)/float(total_cards)
		var prop_EV = prop_EVs[DATA.Rarities[rarity]]
		var diff = ((float(prop) / prop_EV) - 1) * 100
		var base_str = "\t\t|\t" if rarity.length() <= 6 else "\t|\t"
		
		var total_str: String = rarity + base_str + str(count) + "\t\t|\t" + str(snappedf(prop, 0.001)) + "\t|\t" + str(snappedf(prop_EV, 0.001)) + "\t|\t" + (" " if diff >=0 else "") + str(snappedf(diff, 0.01)) + "%"
		LOGGER.log_msg(total_str)
	return counts
