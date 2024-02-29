import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new Life(r, c);
    }
  } 
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c].draw();
      if (countNeighbors(r, c) == 3) {
        buffer[r][c] = true;
      } else if (countNeighbors(r, c) == 2 && buttons[r][c].getLife()) {
        buffer[r][c] = true;
      } else {
        buffer[r][c] = false;
      }
    }
  } 

  copyFromBufferToButtons();
}

public void keyPressed() {
  if (running && key == 'e') {
    running = false;
  } else if (key == 'e') {
    running = true;
  } else if (key == 'r' && !running) {
    for (int r = 0; r < NUM_ROWS; r++) {
      for (int c = 0; c < NUM_COLS; c++) {
        int i = (int) (Math.random()*5);
        if (i >= 4) {buffer[r][c] = true;}
        else {buffer[r][c] = false;}
      }
    }
    copyFromBufferToButtons();
  }
}

public void copyFromBufferToButtons() {
  //for (int r = 0; r < NUM_ROWS; r++) {
  //  for (int c = 0; r < NUM_COLS; c++)
  for (int r = 0; r < buttons.length; r++) {
    for (int c = 0; c < buttons[r].length; c++) {
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}
public void copyFromButtonsToBuffer() {
  for (int r = 0; r < buttons.length; r++) {
    for (int c = 0; c < buttons[r].length; c++) {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for (int x = -1; x < 2; x++) {
    for (int i = -1; i < 2; i++) {
      if (isValid(row-i, col-x))
        if (buttons[row-i][col-x].getLife())
          neighbors++;
    }
  }
  if (buttons[row][col].getLife() == true) neighbors -= 1;
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    if (!running)
      alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
