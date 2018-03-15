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
int rows = 5;
int cols;
int resultCounts;
StringList pix = new StringList();

void setup() {
  size(1200, 800);
  artworks = loadJSONArray("data_compressed.json");
  resultCounts = 100; //artworks.size();
  cols = (int)ceil((float)resultCounts/rows);
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

  for (int i=0; i<resultCounts; i++) {
    covers[i] = loadImage(str(i)+".png");
    covers[i].loadPixels();
    int[] sortPix = sort(covers[i].pixels);
    String numArray = join(nf(sortPix, 0), ", "); 
    pix.append(numArray);
  }

  float time = (float)millis()/1000;
  println(time + " seconds");
}

void draw() {
  background(255);
  noStroke();
  colorMode(RGB);
  int index = 0;
  float imgPos = scrollB.getPos();
  for (int i =0; i<rows; i++) {
    for (int j =0; j<cols; j++) {
      String title = artworks.getJSONObject(index).getString("Title");
      String[] artists = artworks.getJSONObject(index).getJSONArray("Artist").getStringArray();
      String artist = join(artists, ", ");
      String year = artworks.getJSONObject(index).getString("Date");
      String colorVal = pix.get(index);
      String[] valuesList = split(colorVal, ", ");
      int colorLength = valuesList.length;

      image(covers[index], 100*j-(100*imgPos*cols/width)+imgPos, 150+(100*i), 100, 100);

      if ((100*j-(100*imgPos*cols/width)+imgPos < mouseX) 
        && (mouseX < 100*(j+1)-(100*imgPos*cols/width)+imgPos) 
        && (150+(100*i) < mouseY) 
        &&(mouseY < 150+(100*(i+1))) ) {
        text(title, 10, 20);
        text(artist, 10, 40);
        text(year, 10, 60);
        fill(0);
        ellipse(700, 100, 150, 150);
        //text(hex(int(valuesList[(int)5000])), 10, 80);
        for (float k=0; k < colorLength; k++) {
          float start = TWO_PI*(k/colorLength);
          float end = TWO_PI*((k+1)/colorLength);
          float r = red(int(valuesList[(int)k]));
          float g = green(int(valuesList[(int)k]));
          float b = blue(int(valuesList[(int)k]));
          fill(r, g, b);
          arc(700, 100, 150, 150, start, end);
        }
      }

      scrollB.update();
      scrollB.display();

      if (index>=resultCounts) {
        break;
      }

      index +=1;
    }
  }
}