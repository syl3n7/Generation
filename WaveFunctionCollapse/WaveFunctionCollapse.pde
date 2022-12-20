PImage tiles[] = new PImage[5];

//function to preload images blank, up, down, left, right
void preload() {
    tiles[0] = loadImage("assets/blank.png");
    tiles[1] = loadImage("assets/up.png");
    tiles[2] = loadImage("assets/down.png");
    tiles[3] = loadImage("assets/left.png");
    tiles[4] = loadImage("assets/right.png");
}

void setup() {
    background(255);
    size(800, 600);
    preload();
}

void draw() {
    //draw the tiles
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            image(tiles[i], i * 50, j * 50);
        }
    }    
}