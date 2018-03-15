/*
Name: Chantel Chan
 Date: March 2018
 
 My project takes artworks from the Museum of Modern Art's collection
 which includes almost 200,000 works from around the world spanning the last 150 years.
 I downloaded Artists.json and Artworks.json, and created a new JSON file called 
 data_compressed.json which contains artworks from the top 101 painters (according to 
 http://www.theartwolf.com/articles/most-important-painters.htm). 
 
 Steps before running:
 1. Processing > Preferences > Increase maximum available memory to 4096 MB
 (might require more memory if you want to load more images)
 2. Save the 3970 images locally
 
 Leave Commented Out: 51-54, 62-65, 73-81, 102-111, 218-249
 */

import java.util.*;
PImage[] covers;
PImage art;
HScrollbar scrollB;
JSONArray artworks;
JSONArray nationality;

int indexStart=3020;
int rows = 4;
int cols;
int resultCounts;

PImage thisArt;
String title;
String[] artists;
String artist;
String year;
String colorVal;
String[] valuesList;
int colorLength;

float ratio;

StringList pix = new StringList();

int[] r_hist = new int[256];
int[] g_hist = new int[256];
int[] b_hist = new int[256];
int[] h_hist = new int[360];
int[] s_hist = new int[360];
int[] v_hist = new int[360];

//boolean allOver;
//boolean allPressed;
//boolean natOver;
//boolean natPressed;

void setup() {
  size(1200, 800);
  artworks = loadJSONArray("data_compressed.json");
  nationality = loadJSONArray("uniqNationalities.json");
  resultCounts = 8; //must be multiple of "int rows"

  //allOver = true;
  //allPressed = true;
  //natOver = false;
  //natPressed = false;

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
    println(resultCounts+indexStart-i);
  }

  float time = (float)millis()/1000;
  println(time + " seconds");
}

void draw() {
  background(255);
  textAlign(CENTER, CENTER);
  noStroke();
  colorMode(RGB);

  /* future implementation: filter through buttons
   fill(255, 153, 255);
   rect(400, height-57, 128, 32);
   fill(255);
   text("All", 400, height-57);
   fill(204, 255, 204);
   rect(800, height-57, 128, 32);
   fill(255);
   text("Nationality", 800, height-57);
   */

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

      if (thisArt.width < thisArt.height) {
        ratio = 350.0/((float)thisArt.height);
      } else {
        ratio = 350.0/((float)thisArt.width);
      }

      float newHeight = thisArt.height*ratio;
      float newWidth = thisArt.width*ratio;

      if ((80*j-(80*imgPos*cols/width)+imgPos < mouseX) 
        && (mouseX < 80*(j+1)-(80*imgPos*cols/width)+imgPos) 
        && (400+(80*i) < mouseY) 
        &&(mouseY < 400+(80*(i+1))) ) {
        imageMode(CORNER);
        image(thisArt, 80*j-(80*imgPos*cols/width)+imgPos-10, 400+(80*i)-10, 100, 100);
        imageMode(CENTER);
        image(thisArt, 1000, 200, newWidth, newHeight);
        fill(0);
        text(title, width/2, height/4 - 20);
        fill(63);
        text("by " + artist, width/2, height/4);
        text(year, width/2, height/4 + 20);

        for (float k=0; k < colorLength; k++) {
          float start = TWO_PI*(k/colorLength);
          float end = TWO_PI*((k+1)/colorLength);
          int r = int(red(int(valuesList[(int)k])));
          int g = int(green(int(valuesList[(int)k])));
          int b = int(blue(int(valuesList[(int)k])));
          int h = int(hue(int(valuesList[(int)k])));
          int s = int(saturation(int(valuesList[(int)k])));
          int v = int(brightness(int(valuesList[(int)k])));
          r_hist[r]++;
          g_hist[g]++;
          b_hist[b]++;
          h_hist[h]++;
          s_hist[s]++;
          v_hist[v]++;
          fill(r, g, b);
          arc(200, 200, 375, 375, start, end);
        }

        int rMax = max(r_hist);
        int gMax = max(g_hist);
        int bMax = max(b_hist);
        int hMax = max(h_hist);
        int sMax = max(s_hist);
        int vMax = max(v_hist);

        for (int m = 0; m<100; m++) {
          colorMode(RGB);
          int rgbcol = int(map(m, 0, 100, 0, 255)); //color
          int hsvcol = int(map(m, 0, 100, 0, 359));
          int r_y = int(map(r_hist[rgbcol], 0, rMax, 0, 150));
          int g_y = int(map(g_hist[rgbcol], 0, gMax, 0, 150));
          int b_y = int(map(b_hist[rgbcol], 0, bMax, 0, 150));
          int h_y = int(map(h_hist[hsvcol], 0, hMax, 0, 150));
          int s_y = int(map(s_hist[hsvcol], 0, sMax, 0, 150));
          int v_y = int(map(v_hist[hsvcol], 0, vMax, 0, 150));
          stroke(rgbcol, 0, 0);
          line(425+m, 0, 425+m, r_y);
          stroke(0, rgbcol, 0);
          line(550+m, 0, 550+m, g_y);
          stroke(0, 0, rgbcol);
          line(675+m, 0, 675+m, b_y);
          
          colorMode(HSB);
          stroke(hsvcol, 360, 360);
          line(425+m, 375, 425+m, 375-h_y);
          stroke(23, hsvcol, 162);
          line(550+m, 375, 550+m, 375-s_y);
          stroke(360, 0, hsvcol);
          line(775-m, 375, 775-m, 375-v_y);
        }
      } else {
        imageMode(CORNER);
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

/* add buttons to filter artworks
 void update() {
 if (overRect(400, height-57, 128, 32)) {
 allOver = true;
 natOver = false;
 } else if (overRect(800, height-57, 128, 32)) {
 allOver = false;
 natOver = true;
 }
 }
 
 void mousePressed() {
 if (allOver) {
 allPressed = true;
 natPressed = false;
 }
 if (natOver) {
 allPressed = false;
 natPressed = true;
 }
 }
 
 
 boolean overRect(int x, int y, int width, int height) {
 if (mouseX >= x-(width/2) && mouseX <= x+(width/2) && 
 mouseY >= y-(height/2) && mouseY <= y+(height/2)) {
 return true;
 } else {
 return false;
 }
 }
 */