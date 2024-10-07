import javax.swing.*;
import java.awt.*;
public class Snake{					//snake个体
	private JLabel sLabel;			//snake个体的容器
	private ImageIcon icon = new ImageIcon("snake.gif");			//当前snake个体颜色
    private int iCell;			//当前snake个体所在的列
    private int iRow;				//当前snake个体所在的行
    private final int iBoxW = 11;	//地图的宽度
    private final int iBoxH = 18;	//地图的高度
	private final int SWIDTH = 16;	//图片的宽度
	static boolean isTouch = false;	//碰壁
	public Snake(){
		sLabel = new JLabel(icon);
		SnakeGame.oPnlLeft.add(sLabel);
	}
	public int getCell(){
		return iCell;
	}
	public int getRow(){
		return iRow;
	}
    public void show(){
        sLabel.setVisible(true);
    }
    public boolean isVisible(){
        return sLabel.isVisible();
    }
    public void hide(){
        sLabel.setVisible(false);
    }
    protected void setPosition(int row, int cell){
		iCell = cell;
		iRow  = row;
        sLabel.setBounds(cell*SWIDTH, row*SWIDTH, SWIDTH, SWIDTH);
    }
	public void moveUp(){
		if(iRow>0)
			setPosition(--iRow,iCell);
		else
			setTouch();
	}
	public void moveDown(){
		if(iRow<iBoxH-1)
			setPosition(++iRow,iCell);
		else
			setTouch();
	}
	public void moveLeft(){
		if(iCell>0)
			setPosition(iRow,--iCell);
		else
			setTouch();
	}
	public void moveRight(){
		if(iCell<iBoxW-1)
			setPosition(iRow,++iCell);
		else
			setTouch();
	}
	static boolean getTouch(){
		return isTouch;
	}
	static void setTouch(){
		isTouch = true;
	}
	static void setImTouch(){
		isTouch = false;
	}
	public Snake clone(){
		Snake tem = new Snake();
		tem.setPosition(this.getRow(),this.getCell());
		return tem;
	}
}
