extends Node2D

var score = 0
# top tier code ftw
# written by adrian

signal throw_in_progress(status: bool)
signal throw_finished()

var in_motion: bool = false
var in_throw: bool = false

var touched_ground: bool = false

var multiplier: int = 0
