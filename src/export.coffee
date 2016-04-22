
fs = require "fs"
CardGameGenerator = require "card-game-generator"

counters = {}
# for fname in fs.readdirSync "images/counters"
# 	if fname.match /\.png/
# 		counter_name = fname.replace /[\-.].*/, ""
# 		if m = fname.match /-(plus|minus|front|back|obverse|reverse)/
# 			side = {
# 				"plus": "obverse"
# 				"minus": "reverse"
# 				"front": "obverse"
# 				"back": "reverse"
# 				"obverse": "obverse"
# 				"reverse": "reverse"
# 			}[m[1]]
# 			counters[counter_name] ?= {type: "tile"}
# 			counters[counter_name][side] = fname
# 		else
# 			counters[counter_name] = {type: "token", fname}

cardSets = JSON.parse(fs.readFileSync("cards.json", "utf8"))

cgg = new CardGameGenerator {cardSets, counters}

cgg.renderCards
	page: "index.html"
	cardWidth: 300
	cardHeight: 400
	scale: 2
	debug: off
	to: "export/images"
	(err)->
		throw err if err
		cgg.exportTabletopSimulatorSave
			to: "export/"
			saveName: "Prosperity"
			imagesURL: "https://raw.githubusercontent.com/1j01/prosperity/gh-pages/images"
			renderedImagesURL: "https://raw.githubusercontent.com/1j01/prosperity/gh-pages/export/images"
			(err)->
				throw err if err
				cgg.exportSaveToTabletopSimulatorChest()
