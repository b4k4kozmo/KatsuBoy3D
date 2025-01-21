extends Control

signal opened
signal closed

var dialogueTest = Dialogues.new()

var isOpen: bool = false

func open():
	visible = true
	$NinePatchRect/RichTextLabel.text = str(dialogueTest.speech)
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()
