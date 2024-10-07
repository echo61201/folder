import javax.swing.*;
import java.awt.*;
public class Snake{					//snake����
	private JLabel sLabel;			//snake���������
	private ImageIcon icon = new ImageIcon("snake.gif");			//��ǰsnake������ɫ
    private int iCell;			//��ǰsnake�������ڵ���
    private int iRow;				//��ǰsnake�������ڵ���
    private final int iBoxW = 11;	//��ͼ�Ŀ��
    private final int iBoxH = 18;	//��ͼ�ĸ߶�
	private final int SWIDTH = 16;	//ͼƬ�Ŀ��
	static boolean isTouch = false;	//����
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
