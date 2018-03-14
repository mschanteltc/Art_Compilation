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

PImage[] covers;
HScrollbar scrollB;
JSONArray artworks;
int rows = 6;
int cols;
int resultCounts;



void setup() {
  size(1200, 800);
  artworks = loadJSONArray("data_compressed.json");
  resultCounts = artworks.size()/4;
  cols = ceil(resultCounts/6);
  covers = new PImage[resultCounts];
  scrollB = new HScrollbar(0, height-8, width, 16, 8);
  for (int i =0; i<resultCounts; i++) 
  {
    String imageURL = artworks.getJSONObject(i).getString("ThumbnailURL");
    covers[i] = loadImage(imageURL);
    println(resultCounts-i);
  }
}

void draw() {
  background(255);
  int index = 0;
  float imgPos = scrollB.getPos();
  for (int i =0; i<rows; i++) {
    for (int j =0; j<cols; j++) {
      String title = artworks.getJSONObject(index).getString("Title");
      String[] artists = artworks.getJSONObject(index).getJSONArray("Artist").getStringArray();
      String artist = join(artists, ", ");
      String year = artworks.getJSONObject(index).getString("Date");

      image(covers[index], 100*j-(100*imgPos*cols/width)+imgPos, 150+(100*i), 100, 100);

      if ((100*j-(100*imgPos*cols/width)+imgPos < mouseX) 
              && (mouseX < 100*(j+1)-(100*imgPos*cols/width)+imgPos) 
              && (150+(100*i) < mouseY) 
              &&(mouseY < 150+(100*(i+1))) ) {
        text(title, 10, 20);
        text(artist, 10, 40);
        text(year, 10, 60);
      }//prin
      scrollB.update();
      scrollB.display();
      if (index>=resultCounts) {
        break;
      }
      index +=1;
    }
  }
}