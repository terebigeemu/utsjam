extends Node2D

var score = 0
# top tier code ftw
# written by adrian

signal throw_in_progress(status: bool)
signal throw_finished()

var in_motion: bool = false
