extends Node3D
class_name PackZoneNode

signal Results(ExpansionID : DATA.ExpansionIDs, CardList : Array[Card])
signal finished

const STARTING_PACK_HEIGHT: float = 5.0

func enter_pack_zone(): 
	#while get_child_count() > 0:
		#var kid: Node = get_child(0)
		#remove_child(kid)
		#kid.queue_free()
		#
	DEBUG_add_pack()

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

func DEBUG_add_pack():
	var rand = int(floor(RNG.random_value() * DATA.ExpansionIDs.size()))
	var pull: Dictionary = determine_pack_pull(rand)
	var pack_rarity: DATA.Rarities = pull["RARITY"]
	var pack_content: Array[Card] = pull["CONTENT"]
	
	#var paired_content = Array[PlayablePair]
	#for 
	
	LOGGER.log_msg("pack_zone.gd: generated a " + DATA.Rarities.find_key(pack_rarity) + " pack from " + DATA.ExpansionIDs.find_key(rand))
	Results.emit(rand, pack_content)
	
	var pack: Pack = Pack.new(pack_rarity, pack_content)
	pack.set_name(DATA.Rarities.find_key(pack_rarity).to_lower()+"_pack_"+str(int(RNG.random_value()*1000)))
	#pack.position.y = STARTING_PACK_HEIGHT
	add_child(pack)
	pack.finished.connect(finished.emit)



## [b]Purpose[/b]: generates a pack from a requested expansion[br]
## [b]ExpansionID[/b]: the expansion to generate a pack from. (see [enum DATA.ExpansionIDs])[br]
## [b]Returns[/b]: nothing. emits [signal Results] when completed.
func determine_pack_pull(ExpansionID : DATA.ExpansionIDs) -> Dictionary:
	var pack_rarity: DATA.Rarities = determine_pack_rarity(ExpansionID)
	var content_rarities: Array[DATA.Rarities] = determine_pack_content_rarities(ExpansionID, pack_rarity)
	var partner_rarities: Array[DATA.Rarities] = determine_pack_content_rarities(ExpansionID, pack_rarity, false)
	var content: Array[Card] = determine_pack_contents(ExpansionID, content_rarities, partner_rarities)
	return {"RARITY":pack_rarity, "CONTENT":content}

## [b]Purpose[/b]: determines the rarity for a pack from a requested expansion[br]
## [b]ExpansionID[/b]: the expansion to generate a pack from. (see [enum DATA.ExpansionIDs])[br]
## [b]Returns[/b]: a rarity. (see [enum DATA.Rarities])
func determine_pack_rarity(ExpansionID : DATA.ExpansionIDs) -> DATA.Rarities:
	var pack_rarity_odds: Array[float] = DATA.get_pack_rarity_odds(ExpansionID)
	var thresh = RNG.random_value()
	
	for r in DATA.Rarities:
		thresh -= pack_rarity_odds[DATA.Rarities[r]]
		if thresh <= 0: return DATA.Rarities[r]
	
	@warning_ignore("int_as_enum_without_match")
	return -1 as DATA.Rarities


## [b]Purpose[/b]: determines the rarity for each content in a pack from a requested expansion[br]
## [b]ExpansionID[/b]: the expansion to generate a pack from. (see [enum DATA.ExpansionIDs])[br]
## [b]PackRarity[/b]: the rarity of pack to generate content for. (see [enum DATA.Rarities])[br]
## [b]Returns[/b]: an sorted array of rarities. (see [enum DATA.Rarities])
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

#func _notification(what: int) -> void: if visible and what == NOTIFICATION_WM_GO_BACK_REQUEST: finished.emit()
