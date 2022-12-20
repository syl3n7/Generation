Cell c;
class Grid{
    //properties
    h = height;
    w = width;
    Cell = new Cell(50, 50);
    
    //constructor
    Grid(h, w) {
        for (int i = 0; i < h * w; i++) {
            grids[i] = -1;
            for (int j = 0; j < 5; j++) {
                grids[i][j] = 0;
            }
        }
    }
}