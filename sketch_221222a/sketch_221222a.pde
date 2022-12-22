// Define a 2D array to represent the grid of cells
int[][] grid;

void setup() {
  size(500, 500);
  // Initialize the grid array with the dimensions of the grid and the initial state of each cell
  int gridWidth = 50;
  int gridHeight = 50;
  grid = new int[gridWidth][gridHeight];
  for (int i = 0; i < gridWidth; i++) {
    for (int j = 0; j < gridHeight; j++) {
      grid[i][j] = 0;  // 0 represents an empty cell, 1 represents a filled cell
    }
  }

  // Define a list of input samples
  int[][] samples = {
    {1, 1, 1},
    {1, 0, 1},
    {1, 1, 1}
  };

  // Apply the wavefunction collapse algorithm to the grid
  wavefunctionCollapse(grid, samples);
}

void draw() {
  // Visualize the resulting pattern on the screen
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (grid[i][j] == 1) {
        fill(255);  // Fill the cell with white if it's filled
      } else {
        fill(0);  // Fill the cell with black if it's empty
      }
      rect(i*20, j*20, 20, 20);  // Draw the cell on the screen
    }
  }
}

void wavefunctionCollapse(int[][] grid, int[][] samples) {
  // Iterate through the grid, applying the wavefunction collapse algorithm to each cell in turn
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      // Select a random sample from the list of input samples
      int sampleIndex = int(random(samples.length));
      int[] sample = samples[sampleIndex];
      print("\nSelected sample: " + sample);  // Debugging line

      // Calculate the dimensions of the sample grid
      int sampleRows = sample.length / 3;
      int sampleCols = 3;

      // Check if the sample fits within the grid at the current position
      if (i + sampleRows > grid.length || j + sampleCols > grid[0].length) {  // Fix: Use "sampleRows" and "sampleCols" instead of "(sample.length / 3)"
        continue;  // Skip this sample if it doesn't fit
      }

      // Check if the sample conflicts with any already-placed samples in the grid
      boolean conflict = false;
      for (int m = 0; m < sample.length; m++) {
        int row = m / 3;
        int col = m % 3;
        if (grid[i+row][j+col] == 1 && sample[m] == 1) {
          conflict = true;  // Conflict detected
          break;
        }
      }
      if (conflict) {
        continue;  // Skip this sample if it conflicts with any already-placed samples
      }

      // If the sample fits and doesn't conflict, place it in the grid
      for (int m = 0; m < sample.length; m++) {
        int row = m / 3;
        int col = m % 3;
        grid[i+row][j+col] = sample[m];
      }
    }
  }
}
