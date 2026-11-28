extends Label


func _set_pos(pos: int) -> void:
	text = text.replace("{pos}", str(pos + 1))


func _set_username(username: String) -> void:
	text = text.replace("{username}", username)


func _set_score(score: int) -> void:
	text = text.replace("{score}", str(int(score)))


func _set_multiplier(multiplier: String) -> void:
	if not multiplier.is_empty():
		text = text.replace("{multiplier}", str(int(multiplier)))


func set_data(entry: TaloLeaderboardEntry) -> void:
	_set_pos(entry.position)
	_set_username(entry.player_alias.identifier)
	_set_score(entry.score)
	_set_multiplier(entry.get_prop("multiplier", ""))

	if not entry.deleted_at.is_empty():
		text += " (archived)"
