
fs = require "fs"
CardGameGenerator = require "card-game-generator"

# counters = {}
# for fname in fs.readdirSync "images/counters"
# 	if fname.match /\.png/
# 		counter_name = fname.replace /[\-.].*/, ""
# 		if m = fname.match /-(front|back)/
# 			front_back = m[1]
# 			counters[counter_name] ?= {type: "tile"}
# 			counters[counter_name][front_back] = fname
# 		else
# 			counters[counter_name] = {type: "token", fname}

cgg = new CardGameGenerator
	cardSets: JSON.parse(fs.readFileSync("cards.json", "utf8"))
	# counters: counters
	imagesURL: "https://raw.githubusercontent.com/1j01/prosperity/gh-pages/images/"
	exportedImagesURL: "https://raw.githubusercontent.com/1j01/prosperity/gh-pages/export/images/"

cgg.export
	page: "index.html"
	cardWidth: 300
	cardHeight: 400
	scale: 2
	debug: off
	exportFolder: "export/images/"
	(err)->
		throw err if err
		cgg.exportToTabletopSimulator
			exportFolder: "export/"
			saveName: "Prosperity"
