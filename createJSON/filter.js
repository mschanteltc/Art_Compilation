fs = require('fs');
let finished = [];
let constituentID = [//url: http://www.theartwolf.com/articles/most-important-painters.htm
                      4609, //PABLO PICASSO
                      //GIOTTO DI BONDONE
                      //LEONARDO DA VINCI
                      4869, //PAUL CÉZANNE
                      //REMBRANDT VAN RIJN
                      //DIEGO VELÁZQUEZ
                      2981, //WASSILY KANDINSKY
                      4058, //CLAUDE MONET
                      //CARAVAGGIO
                      //JOSEPH MALLORD WILLIAM TURNER
                      //JAN VAN EYCK
                      //ALBRECHT DÜRER
                      4675, //JACKSON POLLOCK
                      //MICHELANGELO BUONARROTI
                      2098, //PAUL GAUGUIN
                      2274, //FRANCISCO DE GOYA //did not find any
                      2206, //VINCENT VAN GOGH
                      3721, //ÉDOUARD MANET
                      5047, //MARK ROTHKO
                      3832, //HENRI MATISSE
                      //RAPHAEL
                      370, //JEAN-MICHEL BASQUIAT
                      4614, //EDVARD MUNCH
                      //TITIAN
                      4057, //PIET MONDRIAN
                      //PIERO DELLA FRANCESCA
                      //PETER PAUL RUBENS
                      6246, //ANDY WARHOL
                      4016, //JOAN MIRÓ
                      //TOMMASO MASACCIO
                      1055, //MARC CHAGALL
                      //GUSTAVE COURBET
                      //NICOLAS POUSSIN
                      3213, //WILLEM DE KOONING
                      3130, //PAUL KLEE
                      272, //FRANCIS BACON
                      3147, //GUSTAV KLIMT
                      1474, //EUGÈNE DELACROIX //not found
                      //PAOLO UCCELLO
                      //WILLIAM BLAKE
                      3710, //KAZIMIR MALEVICH
                      //ANDREA MANTEGNA
                      //JAN VERMEER
                      //EL GRECO
                      //CASPAR DAVID FRIEDRICH
                      //WINSLOW HOMER
                      1634, //MARCEL DUCHAMP
                      //GIORGIONE
                      2963, //FRIDA KAHLO
                      //HANS HOLBEIN THE YOUNGER
                      1465, //EDGAR DEGAS
                      //FRA ANGELICO
                      5358, //GEORGES SEURAT
                      //JEAN-ANTOINE WATTEAU
                      1364, //SALVADOR DALÍ
                      1752, //MAX ERNST
                      //TINTORETTO
                      2923, //JASPER JOHNS
                      //SANDRO BOTTICELLI
                      2678, //DAVID HOCKNEY
                      624, //UMBERTO BOCCIONI
                      //JOACHIM PATINIR
                      //DUCCIO DA BUONINSEGNA
                      //ROGER VAN DER WEYDEN
                      //JOHN CONSTABLE
                      //JACQUES-LOUIS DAVID
                      2252, //ARSHILLE GORKY
                      //HIERONYMUS BOSCH
                      //PIETER BRUEGEL THE ELDER
                      //SIMONE MARTINI
                      //FREDERIC EDWIN CHURCH
                      2726, //EDWARD HOPPER
                      1930, //LUCIO FONTANA
                      3748, //FRANZ MARC
                      4869, //PIERRE-AUGUSTE RENOIR
                      6336, //JAMES MCNEILL WHISTLER
                      //THEODORE GÉRICAULT
                      //WILLIAM HOGARTH
                      1253, //CAMILLE COROT
                      744, //GEORGES BRAQUE
                      //HANS MEMLING
                      4907, //GERHARD RICHTER
                      4038, //AMEDEO MODIGLIANI
                      //GEORGES DE LA TOUR
                      //GENTILESCHI, ARTEMISIA
                      //JEAN FRANÇOIS MILLET
                      //FRANCISCO DE ZURBARÁN
                      //CIMABUE
                      1739, //JAMES ENSOR
                      3692, //RENÉ MAGRITTE
                      3569, //EL LISSITZKY
                      5215, //EGON SCHIELE
                      //DANTE GABRIEL ROSSETTI
                      //FRANS HALS
                      //CLAUDE LORRAIN
                      3542, //ROY LICHTENSTEIN
                      4360, //GEORGIA O'KEEFE
                      //GUSTAVE MOREAU
                      //GIORGIO DE CHIRICO
                      6624, //FERNAND LÉGER
                      //JEAN-AUGUSTE-DOMINIQUE INGRES
]; //constituentID array
let originalFilePath = 'Artworks.json'; //PUT UR ORIGINAL FILEPATH HERE ie dumbHoney.json
let endFilePath = 'data_compressed.json'; //PUT WHAT YOU WANT YOUR NEW JSON FILE TO BE CALLED HERE ie honeyIsTheBest.json
fs.readFile(originalFilePath, (err, data) => {
    if(err){
        throw err;
        return;
    }
    artwork = JSON.parse(data);
    for(let i = 0; i < artwork.length; i++) {
        // this if statement might need changing, if you want more stuff like sculptures and whatnot
        if(constituentID.includes(artwork[i].ConstituentID[0])
        && (artwork[i].Classification !== 'Sculpture' || artwork[i].Classification !== 'Architecture')
        && (artwork[i].URL !== null && artwork[i].ThumbnailURL !== null)){
            finished.push(artwork[i]);
        }
    }
    fs.writeFile('data_compressed.json', JSON.stringify(finished));
});
