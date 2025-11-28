extends Node

# Simple locale manager — loads .po for testing. In production use .translation or compiled files.

func set_locale(locale_code: String):
    var path = "res://translations/%s.po" % locale_code
    if ResourceLoader.exists(path):
        var po = load(path)
        TranslationServer.clear()
        TranslationServer.add_translation(po)
        TranslationServer.set_locale(locale_code)

func get_locale():
    return TranslationServer.get_locale()

func _ready():
    # default to Arabic for this demo
    set_locale("ar")
