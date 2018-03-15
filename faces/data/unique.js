/*
Run "node unique.js" on terminal with JSON files
Returns JSON file with unique assigned element values.
 */

const fs = require('fs');
let filepath = 'data_compressed.json';
let writeFilePath = 'uniqDates.json'; //'uniqNationalities.json';
fs.readFile(filepath, 'utf8', (err, data) => {
  if(err) {
      console.log(err);
  } else {
    console.log(typeof data);
    data = data.slice(1, data.length);
    let stuff = JSON.parse(data);
    helper(stuff);
  }
});

const helper = (bunchOfData) => {
    let uniqueStorage = {};
    let uniqueNames = [];
    bunchOfData.forEach((element) => {
        if(!uniqueStorage[element.Date]) { //element.Nationality[0])
            uniqueStorage[element.Date] = true;
            uniqueNames.push(element.Date);
        }
    });
    uniqueNames.sort();
    let data = JSON.stringify(uniqueNames);
    fs.writeFile(writeFilePath, data, (err) => {
        console.log(err);
    });
};
