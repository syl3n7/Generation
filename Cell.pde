class Cell{
    //properties
    PImage tiles[] = new PImage[5];
    int height, width = 0;
    boolean collapsed;
    //constructor
    Cell(int height, int width) {
        this.height = height;
        this.width = width;
        this.collapsed = false;
    }
    
    //function to preload images blank, up, down, left, right
    void preload() {
        tiles[0] = loadImage("assets/blank.png");
        tiles[1] = loadImage("assets/up.png");
        tiles[2] = loadImage("assets/down.png");
        tiles[3] = loadImage("assets/left.png");
        tiles[4] = loadImage("assets/right.png");
    }
    
    void drawme() {
        if (collapsed) {
            image(tiles[1], width, height);
        } else {
            image(tiles[0], width, height);
        }
    }
    
}