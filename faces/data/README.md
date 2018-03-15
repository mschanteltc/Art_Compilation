README.md

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

 Ways to Look at it:
1. View ALL Artworks
  26: indexStart = 0;
  60: resultCounts = artworks.size();
  83-86: comment out;
  121-123: comment out;
  148-198: comment out;

2. View SOME Artworks with Pie Chart
  26: indexStart = arbitrary; //range 0 to resultCounts-indexStart, I chose 3020
  60: resultCounts = 300; //multiple of int row, I chose 100
  154-162: comment out;
  167-198: comment out;

3. View FEW Artworks with Pie Chart and Histogram
  26: indexStart = arbitrary; //range 0 to resultCounts-indexStart, I chose 3020
  60: resultCounts = 300; //multiple of int row, I chose 8
