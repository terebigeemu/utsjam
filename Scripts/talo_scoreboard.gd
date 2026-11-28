extends Node2D

var entry_scene = preload("res://scoreboard_entry.tscn")

@export var leaderboard_internal_name: String = "two-birds-one-stone"
@export var include_archived: bool

@onready var leaderboard_name: Label = %LeaderboardName
@onready var entries_container: VBoxContainer = %Entries
@onready var info_label: Label = %InfoLabel

var _entries_error: bool
var _filter: String = "All"
var _filter_idx: int


func _ready() -> void:
	leaderboard_name.text = "Leaderboard"
	await _load_entries()
	_set_entry_count()


func _set_entry_count():
	if entries_container.get_child_count() == 0:
		info_label.text = (
			"No entries yet!"
			if not _entries_error
			else "Failed loading leaderboard %s. Please report this error!" % leaderboard_internal_name
		)
	else:
		info_label.text = "%s entries" % entries_container.get_child_count()
		if _filter != "All":
			info_label.text += " (%s team)" % _filter


func _create_entry(entry: TaloLeaderboardEntry) -> void:
	var entry_instance = entry_scene.instantiate()
	entry_instance.set_data(entry)
	entries_container.add_child(entry_instance)


func _build_entries() -> void:
	for child in entries_container.get_children():
		child.queue_free()

	var entries = Talo.leaderboards.get_cached_entries(leaderboard_internal_name)
	if _filter != "All":
		entries = entries.filter(
			func(entry: TaloLeaderboardEntry):
				return entry.get_prop("team", "") == _filter,
		)

	for entry in entries:
		_create_entry(entry)


func _load_entries() -> void:
	var page := 0
	var done := false

	while !done:
		var options := Talo.leaderboards.GetEntriesOptions.new()
		options.page = page
		options.include_archived = include_archived

		var res := await Talo.leaderboards.get_entries(leaderboard_internal_name, options)

		if not is_instance_valid(res):
			_entries_error = true
			return

		var entries := res.entries
		var is_last_page := res.is_last_page

		if is_last_page:
			done = true
		else:
			page += 1

	_build_entries()


func _on_button_pressed() -> void:
	position.x = 100000000000
