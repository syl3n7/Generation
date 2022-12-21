import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import java.util.LinkedHashMap;

PImage up;
PImage down;
PImage left;
PImage right;
PImage blank;

int cellSize = 50;
int numRows = 10;
int numCols = 10;
Cell[][] grid;

void setup() {
  size(500, 500);
  frameRate(1000);
  up = loadImage("assets/up.png");
  down = loadImage("assets/down.png");
  left = loadImage("assets/left.png");
  right = loadImage("assets/right.png");
  blank = loadImage("assets/blank.png");

  grid = new Cell[numRows][numCols];
  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
      grid[r][c] = new Cell(r, c, cellSize);
    }
  }

  // initialize the grid with the blank image
  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
      grid[r][c].setImage(blank);
    }
  }
  
  // set the top left cell to the up image
  grid[0][0].setImage(up);

  // apply the Wave Function Collapse algorithm to the randomly selected cell
  waveFunctionCollapse();
}

void draw() {
  //background(255);
  // select a random cell to draw
  int randomRow = int(random(numRows));
  int randomCol = int(random(numCols));
  grid[randomRow][randomCol].display();

}

// void waveFunctionCollapse() {
//   // create a list of possible images for each cell
//   List<List<List<PImage>>> possibleImages = new ArrayList<>();
//   for (int r = 0; r < numRows; r++) {
//     possibleImages.add(new ArrayList<>());
//     for (int c = 0; c < numCols; c++) {
//       List<PImage> images = new ArrayList<>();
//       images.add(up);
//       images.add(down);
//       images.add(left);
//       images.add(right);
//       images.add(blank);
//       possibleImages.get(r).add(images);
//     }
//   }

//   // iterate over each cell in the grid
//   for (int r = 0; r < numRows; r++) {
//     for (int c = 0; c < numCols; c++) {
//       // get the list of possible images for this cell
//       List<PImage> images = possibleImages.get(r).get(c);

//       // check the constraints of the surrounding cells
//       if (r > 0) {
//         PImage topImage = grid[r-1][c].img;
//         images.remove(topImage);
//       }
//       if (c > 0) {
//         PImage leftImage = grid[r][c-1].img;
//         images.remove(leftImage);
//       }

//       // select the most likely image for this cell
//       PImage selectedImage = images.get(0);
//       grid[r][c].setImage(selectedImage);
//     }
//   }
// }

void waveFunctionCollapse() {
  // create a map to store the entropy values for each cell
  Map<Cell, Float> entropies = new HashMap<>();

  // iterate over each cell in the grid
  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
      Cell cell = grid[r][c];

      // create a list of possible images for this cell
      List<PImage> images = new ArrayList<>();
      images.add(up);
      images.add(down);
      images.add(left);
      images.add(right);
      images.add(blank);

      // check the constraints of the surrounding cells
      if (r > 0) {
        PImage topImage = grid[r-1][c].img;
        images.remove(topImage);
      }
      if (c > 0) {
        PImage leftImage = grid[r][c-1].img;
        images.remove(leftImage);
      }

      // calculate the entropy for this cell based on the number of possible images
      float entropy = -log(1.0f / images.size()) / log(2);
      entropies.put(cell, entropy);
    }
  }

  // sort the map by entropy values in ascending order
  entropies = entropies.entrySet()
                       .stream()
                       .sorted(Map.Entry.comparingByValue())
                       .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

  // iterate over the map and set the image for each cell
  for (Map.Entry<Cell, Float> entry : entropies.entrySet()) {
    Cell cell = entry.getKey();
    List<PImage> images = new ArrayList<>();
    images.add(up);
    images.add(down);
    images.add(left);
    images.add(right);
    images.add(blank);

    // check the constraints of the surrounding cells
    int row = cell.x;
    int col = cell.y;
    if (row > 0) {
      PImage topImage = grid[row-1][col].img;
      images.remove(topImage);
    }
    if (col > 0) {
      PImage leftImage = grid[row][col-1].img;
      images.remove(leftImage);
    }

    // select a random image from the list of possible images
    int randomIndex = int(random(images.size()));
    PImage selectedImage = images.get(randomIndex);
    cell.setImage(selectedImage);
  }
}