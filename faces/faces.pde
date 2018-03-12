PImage[] covers;

int rows = 5;
int cols = 10;
int index = 0;

int resultCounts = 50;
void setup() {

  size(1200, 800);
  JSONArray artworks = loadJSONArray("data_compressed.json"); 
  covers = new PImage[resultCounts];
  //println(items.size());

  for (int i =0; i<50; i++) 
  {
    String imageURL = artworks.getJSONObject(i).getString("ThumbnailURL");
    covers[i] = loadImage(imageURL);
    println(imageURL);
  }
}

void draw() {
  while(index < resultCounts )
  {
  for (int i =0; i<rows; i++) {
    for (int j =0; j<cols; j++) {
        image(covers[index], 100+100*j, 100*i);
        index +=1;
      }
    }
  }
}