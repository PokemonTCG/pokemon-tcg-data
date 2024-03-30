var fs = require('fs');

var carddir = "../cards/en/"


var CARD_HOLDER = {};
var SET_HOLDER = {};
var SHINY_SETS = {};

var readSetData = () => {
    fs.readFile("../sets/en.json", 'utf-8', function(err, content) {
        if (err) {
            console.log(err);
          return;
        }
        var setList = JSON.parse(content);
        for(var i = 0; i < setList.length; i++){
            var set = setList[i];
            SET_HOLDER[set.id] = set;
        }
    })
    fs.readFile("shinysets.json", 'utf-8', function(err, content) {
        if (err) {
            console.log(err);
          return;
        }
        var setList = JSON.parse(content);
        for(var i = 0; i < setList.length; i++){
            var setName = setList[i];
            SHINY_SETS[setName] = true;
        }
    })
}

readSetData();

// card modifier should return a card, either modified or not
var cardIterate = (cardModifier, finalCallback) => {
    fs.readdir(carddir, function(err, filenames) {
        if (err) {
          console.log(err);
          return;
        }
        for(var i = 0; i < filenames.length; i++) {
            var filename = filenames[i];
            console.log(`Reading ${filename} (${i})`);
            var last = (i == (filenames.length-1));
          fs.readFile(carddir + filename, 'utf-8', function(err, content) {
            if (err) {
                console.log(err);
              return;
            }
            var cards = JSON.parse(content);
            var newCards = [];
            for(var i = 0; i < cards.length; i++) {
                var newCard = cardModifier(cards[i]);
                CARD_HOLDER[newCard.id] = newCard;
                newCards.push(newCard);
            }
            var oldCardString = JSON.stringify(cards, null, 2);
            var newCardString = JSON.stringify(newCards, null, 2);
            if(oldCardString != newCardString) {
                fs.writeFile(carddir + filename, newCardString, function(err) {
                    if (err) {
                        console.log(err);
                      return;
                    }
                });
            }
            if(this.last){
                finalCallback();
            }
          }.bind({"last": last}));
        };
      });
}

const shinyNameRegex = /(★|radiant|shining)/i; // check easy ones with shiny indicator in name
const shinyRarityRegex = /(shining|shiny|radiant)/i; // more recently shiny is indicated in rarity
const shinyFlavorTextRegex = /(this extremely rare)/i; // bw era shinies have this as their flavor text
const shinyIdRegex = /-(SH|SL)/i; // catches some DP era shinies

var heuristicallyShiny = (card) => {
    if(card.supertype != "Pokémon"){ return false} // there might be some shiny trainer cards ? 
    if(shinyNameRegex.test(card.name)){
        return true;
    }
    if(shinyRarityRegex.test(card.rarity)){
        return true;
    }
    if(shinyFlavorTextRegex.test(card.flavorText)){
        return true;
    }
    if(shinyIdRegex.test(card.id)){
        return true;
    }
    if(SHINY_SETS[card.id.split("-")[0]]){
        return true;
    }
    // TODO: check if it's in an all-shiny set
    return false;
}

var makePreviewPage = (shinyCards) => {
    var html = "<html><head><title>Shiny List</title></head><body>";
    html += `<h1>Shiny Cards Preview (${shinyCards.length} Cards Listed)</h1>`;
    html += "<h3>Make sure everything looks fine here</h3>";
    html += "<div style='display: flex; flex-wrap: wrap;'>";

    shinyCards.sort((a, b)=>{
        return (new Date(SET_HOLDER[a.id.split("-")[0]].releaseDate) - new Date(SET_HOLDER[b.id.split("-")[0]].releaseDate));
    })

    for(var i = 0; i < shinyCards.length; i++){
        var cardID = shinyCards[i].id;
        html += `<img src="https://images.pokemontcg.io/${cardID.split("-")[0]}/${cardID.split("-")[1]}.png" style="width: 200px; margin: 5px;">`
    }
    html += "</div>";
    html += `</body><html>`
    fs.writeFile("shinylist.html", html, () => {});
}

// so that we can quickly open a page displaying all the cards
var openPage = (url) => {
    var start = (process.platform == 'darwin'? 'open': process.platform == 'win32'? 'start': 'xdg-open');
    require('child_process').exec(start + ' ' + url);
}

// bulbapedia lists 369 shinies but hasn't been updated for paldean fates (https://bulbapedia.bulbagarden.net/wiki/List_of_cards_featuring_Shiny_Pok%C3%A9mon)

// finds them heuristically - returns a list of the cards
var findShinies = (verbose) => {
    return new Promise((resolve, reject) => {
        var shinies = [];
        cardIterate((card) => {
            if(heuristicallyShiny(card)){
                shinies.push(card);
                if(verbose)
                    console.log(`${card.name} [${card.id}] is shiny!`)
            }
            return card;
        }, () => {
            if(verbose)
                console.log(`Found ${shinies.length} shiny cards!`);
            resolve(shinies);
        });
    })
}

var getHardcodedShinyIDs = () => {
    return new Promise((resolve, reject) => {
        fs.readFile("hardcodedshinylist.json", 'utf-8', function(err, content) {
            if (err) {
                console.log(err);
                return;
            }
            resolve(JSON.parse(content));
        })
    });
}

var huntCommand = () => {
    findShinies(true);
};

var previewCommand = () => {
    findShinies(false).then((shinies) => {
        getHardcodedShinyIDs().then((hardcodedShinies) => {
            for(var i = 0; i < hardcodedShinies.length; i++){
                shinies.push(CARD_HOLDER[hardcodedShinies[i]]);
            }
            makePreviewPage(shinies);
            openPage("shinylist.html");
        });
    });
}

var printCommand = () => {
    findShinies(false).then((shinies) => {
        getHardcodedShinyIDs().then((hardcodedShinies) => {
            var shinyIDs = [];
            for(var i = 0; i < hardcodedShinies.length; i++){
                shinyIDs.push(hardcodedShinies[i]);
            }
            for(var i = 0; i < shinies.length; i++){
                shinyIDs.push(shinies[i].id);
            }
            shinyIDs.sort((a,b) => {
                return (new Date(SET_HOLDER[a.split("-")[0]].releaseDate) - new Date(SET_HOLDER[b.split("-")[0]].releaseDate));
            })
            fs.writeFile("shinies.json", JSON.stringify(shinyIDs, null, 2), () => {});
        });
    });
}

var updateCommand = () => {
    // TODO: figure out what format should there be for shinies in the data
}

var commands = {};

var addCommand = (name, description, callback) => {
    commands[name] = {
        "description": description,
        "callback": callback
    }
}

var helpCommand = () => {
    // print help
    console.log("Usage: node shinyhunter.js <command>\nAvailable Commands:");
    var longestCommand = 0;
    for(var key in commands){
        if(key.length > longestCommand) {
            longestCommand = key.length;
        }
    }
    for(var key in commands){
        console.log(`${key.padEnd(longestCommand)} -- ${commands[key].description}`);
    }
}

addCommand("hunt", "Finds and logs shiny cards heuristically", huntCommand);
addCommand("preview", "Opens a page showing all the shiny cards, found heuristically and hardcoded", previewCommand);
addCommand("print", "Prints a list of all known shiny card IDs to \"shinies.json\"", printCommand);
addCommand("update", "Updates the actual card data with shiny information [not yet implemented]", printCommand);
addCommand("help", "Prints this screen", helpCommand);



if(process.argv.length > 2){
    if(commands[process.argv[2]]){
        commands[process.argv[2]].callback();
    }
} else {
    helpCommand();
}

