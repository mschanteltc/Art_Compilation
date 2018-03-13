PImage[] covers;
HScrollbar scrollB;
int rows = 10;
int cols = 50;

int resultCounts = 498;
void setup() {

  size(1200, 800);
  JSONArray artworks = loadJSONArray("data_compressed.json"); 
  covers = new PImage[resultCounts];
  scrollB = new HScrollbar(0, height-8, width, 16, 8);
  //println(items.size());

  for (int i =750; i<1248; i++) 
  {
    String imageURL = artworks.getJSONObject(i).getString("ThumbnailURL");
    covers[i-750] = loadImage(imageURL);
    println(i + imageURL);
  }
}

void draw() {
  int index = 0;
  float imgPos = scrollB.getPos();
  for (int i =0; i<rows; i++) {
    for (int j =0; j<cols; j++) {
      image(covers[index], 100*j-(100*imgPos*cols/width)+imgPos, 100*i, 100, 100);
      index +=1;
      scrollB.update();
      scrollB.display();
      if (index>=resultCounts) {
        break;
      }
    }
  }
}