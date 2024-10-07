public class SnakeList 
{
	Snake aoSnakes[];
	static Snake Food;
    static int iLen;
    static int iMaxLen;
	private int heading;
	public SnakeList(){
		iLen = 3;
		heading = 38;
		aoSnakes = new Snake[iLen];
		for (int i=0; i<iLen ;i++ ){
			aoSnakes[i] = new Snake();
			aoSnakes[i].setPosition(15 + i, 5);
			aoSnakes[i].hide();
		}
	}
	public void show(){
		for(int i=0;i<aoSnakes.length;i++)
			aoSnakes[i].show();
	}
	public void hide(){
		for(int i=0;i<aoSnakes.length;i++)
			aoSnakes[i].hide();
	}
	public void changeHeading(int way){
		heading = way;
	}
	public int getHeading(){
		return heading;
	}
	public void move(){
		hide();
		if(aoSnakes[0].getRow()==Food.getRow()&&aoSnakes[0].getCell()==Food.getCell())
			eat();
		Snake tempSnakes[] = new Snake[iLen-1];
		for(int i=0;i<tempSnakes.length;i++){
			tempSnakes[i] = aoSnakes[i].clone();
		}
		switch(heading){
			case 37:
				aoSnakes[0].moveLeft();
				break;
			case 38:
				aoSnakes[0].moveUp();
				break;
			case 39:
				aoSnakes[0].moveRight();
				break;
			case 40:
				aoSnakes[0].moveDown();
				break;
			default:
				break;
		}
		for(int j=0;j<iLen-1;j++){
			aoSnakes[j+1].setPosition(tempSnakes[j].getRow(),tempSnakes[j].getCell());
			tempSnakes[j].hide();
		}
		show();
	}
	public void eat(){
		Snake tempSnakes[] = new Snake[iLen];
		for(int i=0;i<tempSnakes.length;i++){
			tempSnakes[i] = aoSnakes[i].clone();
			tempSnakes[i].hide();
		}
		aoSnakes = new Snake[++iLen];
		SnakeGame.oLblSnakeLen.setText(Integer.toString(iLen));
		aoSnakes[0] = new Snake();
		aoSnakes[0].setPosition(Food.getRow(),Food.getCell());
		for(int i=1;i<iLen;i++){
			aoSnakes[i] = tempSnakes[i-1].clone();
		}
		Food.hide();
		Food = createSnake();
	}
	public Snake createSnake(){
		int k;
		Snake Food = new Snake();
		do{
			k = 0;
			Food.setPosition((int)(Math.random()*18),(int)(Math.random()*11));
			for(int i=0;i<aoSnakes.length;i++){
				if(aoSnakes[i].getRow()==Food.getRow()&&aoSnakes[i].getCell()==Food.getCell()){
					k = i+1;
					break;
				}
			}
		}
		while(k>0);
		return Food;
	}
	public boolean isHickSelf(){
		boolean ishick = false;
		switch(getHeading()){
            case 37:
				if(existSnake(aoSnakes[0].getRow(),aoSnakes[0].getCell()-1))ishick = true;break;
            case 38:
				if(existSnake(aoSnakes[0].getRow()-1,aoSnakes[0].getCell()))ishick = true;break;
            case 39:
				if(existSnake(aoSnakes[0].getRow(),aoSnakes[0].getCell()+1))ishick = true;break;
            case 40:
				if(existSnake(aoSnakes[0].getRow()+1,aoSnakes[0].getCell()))ishick = true;break;
		}
		return ishick;
	}
	public boolean existSnake(int aRow,int aCell){
		int k=1000;
		for(int i=0;i<iLen;i++){
			if(aoSnakes[i].getRow()==aRow && aoSnakes[i].getCell()==aCell){
				k = i;
				break;
			}
		}
		if(k==1000)
			return false;
		else
			return true;
	}
}
