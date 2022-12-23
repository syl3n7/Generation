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
  frameRate(10);
  smooth(8);
  up = loadImage("assets/up.png");
  down = loadImage("assets/down.png");
  left = loadImage("assets/left.png");
  right = loadImage("assets/right.png");
  blank = loadImage("assets/blank.png");

  randomSeed(millis());

  grid = new Cell[numRows][numCols];
  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
      grid[r][c] = new Cell(r, c, cellSize);
    }
  }

  // create a list with all images
  List<PImage> Limages = new ArrayList<>();
  Limages.add(up);
  Limages.add(down);
  Limages.add(left);
  Limages.add(right);
  Limages.add(blank);

  print(Limages.indexOf(blank));

  // initialize the grid with the blank image
  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
      int rCell = int(random(Limages.indexOf(blank)));
      if(rCell == 0){
        grid[r][c].setImage(up);
        grid[r][c].display();
      }
      if(rCell == 1){
        grid[r][c].setImage(down);
        grid[r][c].display();
      }
      if(rCell == 2){
        grid[r][c].setImage(left);
        grid[r][c].display();
      }
      if(rCell == 3){
        grid[r][c].setImage(right);
        grid[r][c].display();
      }
      if(rCell == 4){
        grid[r][c].setImage(blank);
        grid[r][c].display();
      }
    }
  }

  // set the top left cell to the up image
  //grid[5][9].setImage(up);
  
}

void draw() {
  //background(255);
  // select a random cell to draw
  //int randomRow = int(random(numRows));
  //int randomCol = int(random(numCols));
  
  // apply the Wave Function Collapse algorithm to the randomly selected cell
  for (int r = 0; r < numRows; r++){
    for (int c = 0; c < numCols; c++){
      grid[r][c].display();
      delay(int(random(50, 200)));
      waveFunctionCollapse(r, c);
      delay(int(random(50, 200)));
      grid[r][c].display();
    }
  }
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

  //check the constraints of the current cell
  if (row > 0) {
    PImage topImage = grid[row-1][col].img;
    images.remove(topImage);
  }
  if (col > 0) {
    PImage leftImage = grid[row][col-1].img;
    images.remove(leftImage);
  }
  if (row < numRows-1) {
    PImage bottomImage = grid[row+1][col].img;
    images.remove(bottomImage);
  }
  if (col < numCols-1) {
    PImage rightImage = grid[row][col+1].img;
    images.remove(rightImage);
  }

  // calculate the entropy of this cell based on the constraints of the current cell
  for (PImage image : images) {
    float entropy = 0;
    if (row > 0) {
      PImage topImage = grid[row-1][col].img;
      if (topImage == image) {
        entropy += 1;
      }
    }
    if (col > 0) {
      PImage leftImage = grid[row][col-1].img;
      if (leftImage == image) {
        entropy += 1;
      }
    }
    if (row < numRows-1) {
      PImage bottomImage = grid[row+1][col].img;
      if (bottomImage == image) {
        entropy += 1;
      }
    }
    if (col < numCols-1) {
      PImage rightImage = grid[row][col+1].img;
      if (rightImage == image) {
        entropy += 1;
      }
    }
    entropies.put(cell, entropy);
  }

  //replace the current cell with the image with the lowest entropy
  cell.setImage(images.get(0));
  for (Map.Entry<Cell, Float> entry : entropies.entrySet()) {
    if (entry.getValue() < entropies.get(cell)) {
      cell.setImage(entry.getKey().img);
    }
  }
  
}
