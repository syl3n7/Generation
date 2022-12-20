

Array grids[] = new Array[5];

var DIM = 2;



void setup() {
    background(255);
    size(250, 250);
}

void draw() {
    //draw the tiles
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            image(tiles[i], i * 50, j * 50);
        }
    }    
}