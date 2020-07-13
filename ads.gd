extends Node


var gdads = Engine.get_singleton("GodotAds")
var Mopub = Engine.get_singleton("GDMopub")
var _dict = Dictionary()

func init():
	gdads.init(get_instance_id())
	_dict["BannerAd"] = true
	_dict["InterstitialAd"] = true
	_dict["BannerGravity"] = "BOTTOM" # or TOP
	_dict["BannerAdId"] = "d6ae47ac7e50492584f886cfb8ed6d95"
	_dict["InterstitialAdId"] = "673f4b5905d74639840d46a59c664b06"
	Mopub.init(_dict, get_instance_id())
