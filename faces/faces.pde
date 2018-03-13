PImage[] covers;
HScrollbar scrollB;
int rows = 5;
int cols = 30;

int resultCounts = 150;
void setup() {

  size(1200, 800);
  JSONArray artworks = loadJSONArray("data_compressed.json"); 
  covers = new PImage[resultCounts];
  scrollB = new HScrollbar(0, height-8, width, 16, 8);
  //println(items.size());

  for (int i =2500; i<2650; i++) 
  {
    String imageURL = artworks.getJSONObject(i).getString("ThumbnailURL");
    covers[i-2500] = loadImage(imageURL);
    println(imageURL);
  }
}

void draw() {
  int index = 0;
  float imgPos = scrollB.getPos();
  while (index < resultCounts )
  {
    for (int i =0; i<rows; i++) {
      for (int j =0; j<cols; j++) {
        image(covers[index], 100*j-(imgPos*1.5), 100*i, 100, 100);
        index +=1;
        scrollB.update();
        scrollB.display();
      }
    }
  }
}