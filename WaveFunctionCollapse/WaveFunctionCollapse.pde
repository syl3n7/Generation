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
<<<<<<< Updated upstream
=======
  // apply the Wave Function Collapse algorithm to the randomly selected cell
  waveFunctionCollapse(randomRow, randomCol);
>>>>>>> Stashed changes

}


void waveFunctionCollapse(int row, int col) {
  // create a map to store the entropy values for each cell
  Map<Cell, Float> entropies = new HashMap<>();

  // get the cell at the specified row and column
  Cell cell = grid[row][col];

  // create a list of possible images for this cell
  List<PImage> images = new ArrayList<>();
  images.add(up);
  images.add(down);
  images.add(left);
  images.add(right);
  images.add(blank);

  // check the constraints of the surrounding cells
  if (row > 0) {
    PImage topImage = grid[row-1][col].img;
    images.remove(topImage);
  }
  if (col > 0) {
    PImage leftImage = grid[row][col-1].img;
    images.remove(leftImage);
  }

  // calculate the entropy of this cell
  float entropy = (float) images.size() / (float) (up.width + down.width + left.width + right.width + blank.width);
  entropies.put(cell, entropy);

  // select the image for the cell
  images = new ArrayList<>();
  images.add(up);
  images.add(down);
  images.add(left);
  images.add(right);
  images.add(blank);
  if (row > 0) {
    PImage topImage = grid[row-1][col].img;
    images.remove(topImage);
  }
  if (col > 0) {
    PImage leftImage = grid[row][col-1].img;
    images.remove(leftImage);
  }
  PImage selectedImage = images.get(0);
  cell.setImage(selectedImage);
}
