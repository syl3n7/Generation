class Cell {
  int x;
  int y;
  int size;
  PImage img;

  Cell(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  void setImage(PImage img) {
    this.img = img;
  }

  void display() {
    image(img, x * size, y * size, size, size);
  }
}
