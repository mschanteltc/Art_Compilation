/*
Name: Chantel Chan
 Date: March 2018
 
 My project takes artworks from the Museum of Modern Art's collection
 which includes almost 200,000 works from around the world spanning the last 150 years.
 I downloaded Artists.json and Artworks.json, and created a new JSON file called 
 data_compressed.json which contains artworks from the top 101 painters (according to 
 http://www.theartwolf.com/articles/most-important-painters.htm). 
 
 Steps before running:
 1. Processing > Preferences > Increase maximum available memory to 2048 MB
 2. Load the pictures beforehand. 
 */

import java.util.*;
PImage[] covers;
PImage art;
HScrollbar scrollB;
JSONArray artworks;

int indexStart=3570;
int rows = 4;
int cols;
int resultCounts;

StringList pix = new StringList();

void setup() {
  size(1200, 800);
  artworks = loadJSONArray("data_compressed.json");
  resultCounts = 100; //must be multiple of 4
  cols = (int)ceil(resultCounts/rows);
  covers = new PImage[resultCounts];
  scrollB = new HScrollbar(0, height-8, width, 16, 8);

  /* I saved the thumbnail PNG's locally on my disk to save processing time
   for (int i =0; i<resultCounts; i++) 
   {
   String imageURL = artworks.getJSONObject(i).getString("ThumbnailURL");
   covers[i] = loadImage(imageURL);
   covers[i].save(str(i)+".png");
   println(resultCounts-i); //print countdown
   }
   */

  for (int i=indexStart; i<resultCounts+indexStart; i++) {
    covers[i-indexStart] = loadImage(str(i)+".png");
    covers[i-indexStart].loadPixels();
    int[] sortPix = sort(covers[i-indexStart].pixels);
    String numArray = join(nf(sortPix, 0), ", "); 
    pix.append(numArray);
  }

  float time = (float)millis()/1000;
  println(time + " seconds");
}

void draw() {
  background(255);
  textAlign(CENTER);
  noStroke();
  colorMode(RGB);
  int index = indexStart;
  float imgPos = scrollB.getPos();
  for (int i =0; i<rows; i++) {
    for (int j =0; j<cols; j++) {
      PImage thisArt = covers[index-indexStart];
      String title = artworks.getJSONObject(index).getString("Title");
      String[] artists = artworks.getJSONObject(index).getJSONArray("Artist").getStringArray();
      String artist = join(artists, ", ");
      String year = artworks.getJSONObject(index).getString("Date");
      String colorVal = pix.get(index-indexStart);
      String[] valuesList = split(colorVal, ", ");
      int colorLength = valuesList.length;
      

      if ((80*j-(80*imgPos*cols/width)+imgPos < mouseX) 
        && (mouseX < 80*(j+1)-(80*imgPos*cols/width)+imgPos) 
        && (400+(80*i) < mouseY) 
        &&(mouseY < 400+(80*(i+1))) ) {
        image(thisArt, 80*j-(80*imgPos*cols/width)+imgPos-10, 400+(80*i)-10, 100, 100);
        //image(thisArt, 80*j-(80*imgPos*cols/width)+imgPos-10, 400+(80*i)-10, 100, 100);
        text(title, width/2, 20);
        text(artist, width/2, 40);
        text(year, width/2, 60);
        
        for (float k=0; k < colorLength; k++) {
          float start = TWO_PI*(k/colorLength);
          float end = TWO_PI*((k+1)/colorLength);
          float r = red(int(valuesList[(int)k]));
          float g = green(int(valuesList[(int)k]));
          float b = blue(int(valuesList[(int)k]));
          fill(r, g, b);
          arc(200, 200, 375, 375, start, end);
        }
        
      }
      else{
        image(thisArt, 80*j-(80*imgPos*cols/width)+imgPos, 400+(80*i), 80, 80);
      }

      scrollB.update();
      scrollB.display();

      if (index-indexStart >= resultCounts) {
        break;
      }

      index +=1;
    }
  }
}