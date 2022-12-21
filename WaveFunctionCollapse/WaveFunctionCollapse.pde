import java.util.List;


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
  frameRate(20);
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


}

void draw() {
  //background(255);
  // select a random cell to draw
  int randomRow = int(random(numRows));
  int randomCol = int(random(numCols));
  grid[randomRow][randomCol].display();
  // apply the Wave Function Collapse algorithm to the randomly selected cell
  waveFunctionCollapse();
}

void waveFunctionCollapse() {
  // create a list of possible images for each cell
  List<List<List<PImage>>> possibleImages = new ArrayList<>();
  for (int r = 0; r < numRows; r++) {
    possibleImages.add(new ArrayList<>());
    for (int c = 0; c < numCols; c++) {
      List<PImage> images = new ArrayList<>();
      images.add(up);
      images.add(down);
      images.add(left);
      images.add(right);
      images.add(blank);
      possibleImages.get(r).add(images);
    }
  }

  // iterate over each cell in the grid
  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
      // get the list of possible images for this cell
      List<PImage> images = possibleImages.get(r).get(c);

      // check the constraints of the surrounding cells
      if (r > 0) {
        PImage topImage = grid[r-1][c].img;
        images.remove(topImage);
      }
      if (c > 0) {
        PImage leftImage = grid[r][c-1].img;
        images.remove(leftImage);
      }

      // select the most likely image for this cell
      PImage selectedImage = images.get(0);
      grid[r][c].setImage(selectedImage);
    }
  }
}

