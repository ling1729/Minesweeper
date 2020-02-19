public static int NUM_ROWS = 20;
public static int NUM_COLS = 20;
import de.bezier.guido.*;
private boolean gameOver = false;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private int numbombs = 50;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    
    for(int i = 0; i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_COLS; j++){
            buttons[i][j]= new MSButton(i, j);
        }
    }

    
    setMines(numbombs);
}

public void setMines(int num)
{
    while(mines.size() < num)
    {
        int a = (int)(Math.random() * NUM_ROWS);
        int b = (int)(Math.random() * NUM_COLS);
        if(!mines.contains(buttons[a][b]))
            mines.add(buttons[a][b]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();

}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public boolean isValid(int row, int col, int rows, int cols){
  return row < rows && row >= 0 && col < cols && col >= 0; 
}

public int countMines(int row, int col)
{
    return (
    ((isValid(row - 1, col, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row - 1][col])) ? 1 : 0) + 
    ((isValid(row, col + 1, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row][col + 1])) ? 1 : 0) + 
    ((isValid(row + 1, col, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row + 1][col])) ? 1 : 0) + 
    ((isValid(row, col - 1, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row][col - 1])) ? 1 : 0) +
    ((isValid(row - 1, col - 1, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row - 1][col - 1])) ? 1 : 0) +
    ((isValid(row - 1, col + 1, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row - 1][col + 1])) ? 1 : 0) +
    ((isValid(row + 1, col - 1, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row + 1][col - 1])) ? 1 : 0) +
    ((isValid(row + 1, col + 1, NUM_ROWS, NUM_COLS) && mines.contains(buttons[row + 1][col + 1])) ? 1 : 0)
  );
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        if(gameOver) return;
        
        if(!clicked && (keyPressed || mouseButton == RIGHT))
        {
            flagged = !flagged;
            if(!flagged)
              clicked = false;
        }
        else if(mines.contains(this))
        {
            displayLosingMessage();
            gameOver = true;
        }
        else if(countMines(r,c) > 0)
        {
            clicked = true;
            label = "" + countMines(r,c);
        }
        else
        {
        	clicked = true;
        	if(isValid(r - 1,c, NUM_ROWS, NUM_COLS) && !buttons[r - 1][c].clicked)
              buttons[r - 1][c].mousePressed();
           	if(isValid(r + 1,c, NUM_ROWS, NUM_COLS) && !buttons[r + 1][c].clicked)
              buttons[r + 1][c].mousePressed();
           	if(isValid(r,c - 1, NUM_ROWS, NUM_COLS) && !buttons[r][c - 1].clicked)
              buttons[r][c - 1].mousePressed();
           	if(isValid(r,c + 1, NUM_ROWS, NUM_COLS) && !buttons[r][c + 1].clicked)
              buttons[r][c + 1].mousePressed();
           	if(isValid(r - 1,c + 1, NUM_ROWS, NUM_COLS) && !buttons[r - 1][c + 1].clicked)
              buttons[r - 1][c + 1].mousePressed();
           	if(isValid(r + 1,c + 1, NUM_ROWS, NUM_COLS) && !buttons[r + 1][c + 1].clicked)
              buttons[r + 1][c + 1].mousePressed();
           	if(isValid(r - 1,c - 1, NUM_ROWS, NUM_COLS) && !buttons[r - 1][c - 1].clicked)
              buttons[r - 1][c - 1].mousePressed();
           	if(isValid(r + 1,c - 1, NUM_ROWS, NUM_COLS) && !buttons[r + 1][c - 1].clicked)
              buttons[r + 1][c - 1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
