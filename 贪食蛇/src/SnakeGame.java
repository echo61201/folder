import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import java.util.EventObject;
import javax.swing.*;
import java.io.*;
public class SnakeGame extends JApplet{
//**********************************//
	static JPanel oPnlLeft;			//
	private JPanel oPnlControl;		//
	private JPanel oPnlMsg;			//
	private JButton oBtnNewGame;	//
	private JButton oBtnPlay;		//
	private JButton oBtnAbout;		//
	private JLabel oLblMsg;			//
	private JLabel oLblMsg2;		//
	static JLabel oLblSnakeLen;
	static JLabel oLblSnakeLen2;
//	private Choice oChoice;
	private Container oCon;			//
	private Timer timer;
	private File file;
	private final int iX = 10;		//地图的开始坐标
    private final int iY = 10;		//
	private final int SWIDTH = 16;		//图标的宽度
    private final int iCells = 11;	//地图的列数
    private final int iRows = 18;		//地图的行数
    private final int iBoxW = SWIDTH*iCells;	//地图的宽度
    private final int iBoxH = SWIDTH*iRows;		//地图的高度
    private int iPlayState;//0表示：游戏暂停 ，1表示：游戏正在进行 ，2表示：游戏还没有开始
//**********************************//
	static SnakeList sNakes;
	public void init(){
		iPlayState = 2;
		oCon = getContentPane();
		oCon.setLayout(null);
		setFont(new Font("楷体",Font.BOLD,18));
		GameKeyEvent eKeyEvent = new GameKeyEvent();
		GameBtnEvent eBtnEvent = new GameBtnEvent();
		oPnlLeft = new JPanel();
		oPnlControl = new JPanel();
		oPnlMsg = new JPanel();
		oPnlControl.setLayout(new GridLayout(3, 1, 10, 10));
		oPnlLeft.setLayout(null);
		oPnlMsg.setLayout(new GridLayout(4,1));
		oCon.add(oPnlLeft);
		oCon.add(oPnlControl);
		oCon.add(oPnlMsg);
		oPnlMsg.setBackground(new Color(160, 168, 194));
		oPnlLeft.setBackground(new Color(160, 168, 194));
		oPnlMsg.setBounds(205, 10, 85, 120);
		oPnlControl.setBounds(205, 190, 85, 100);
		oPnlLeft.setBounds(10, 10, 176, 288);
		oBtnNewGame = new JButton("新游戏");
		oBtnPlay = new JButton("暂  停");
		oBtnAbout = new JButton("关  于");
		oLblMsg = new JLabel("小蛇当前长度:");
		oLblMsg2 = new JLabel("小蛇纪录长度:");
		file = new File("sankegame.db");
		oLblSnakeLen = new JLabel("3",JLabel.CENTER);
		oLblSnakeLen2 = new JLabel(readfile(),JLabel.CENTER);//change
		oBtnPlay.setEnabled(false);
        oBtnNewGame.addActionListener(eBtnEvent);
        oBtnPlay.addActionListener(eBtnEvent);
        oBtnAbout.addActionListener(eBtnEvent);
        oBtnNewGame.setFocusable(false);
        oBtnPlay.setFocusable(false);
        oBtnAbout.setFocusable(false);
		oPnlControl.add(oBtnNewGame);
		oPnlControl.add(oBtnPlay);
		oPnlControl.add(oBtnAbout);
		oPnlMsg.add(oLblMsg);
		oPnlMsg.add(oLblSnakeLen);
		oPnlMsg.add(oLblMsg2);
		oPnlMsg.add(oLblSnakeLen2);
		addKeyListener(eKeyEvent);
	}
    public class GameKeyEvent extends KeyAdapter{
        public void keyPressed(KeyEvent e){
			if(e.getKeyCode()>36&&e.getKeyCode()<41)
				if((e.getKeyCode()-sNakes.getHeading()!=2)&&(e.getKeyCode()-sNakes.getHeading()!=-2))
					sNakes.changeHeading(e.getKeyCode());
		}
	}
    private class GameBtnEvent implements ActionListener{
        public void actionPerformed(ActionEvent e){
            requestFocus();
            Object oSrc = e.getSource();
            if(oSrc == oBtnNewGame){
                oBtnPlay.setText("暂  停");
				oLblSnakeLen.setText("3");
				if(sNakes!=null){
					sNakes.hide();
				}
                if(timer == null){
                    timer = new Timer(500/2, new GameTimeEvent());
				}
                else
                if(timer.isRunning()){
                    timer.stop();
					sNakes.Food.hide();
					sNakes.Food = null;
					sNakes.hide();
				}
				Snake.setImTouch();
				sNakes = new SnakeList();
				sNakes.show();
				if(sNakes.Food==null){
					sNakes.Food = sNakes.createSnake();
				}
                timer.start();
                iPlayState = 0;
                oBtnPlay.setEnabled(true);
                return;
            }
            if(oSrc == oBtnPlay){
                if(iPlayState == 1){
                    iPlayState = 0;
                    oBtnPlay.setText("暂  停");
                    if(!timer.isRunning())
                        timer.start();
                } else
                if(iPlayState == 0){
                    iPlayState = 1;
                    oBtnPlay.setText("开  始");
                    if(timer.isRunning())
                        timer.stop();
                }
                return;
            }
            if(oSrc == oBtnAbout){
                JOptionPane.showMessageDialog(null,"制 作 :  黄军\nEmail: huangjun@163.com");
                return;
            } 
			else
                return;
        }
    }
	private class GameTimeEvent implements ActionListener{
		public void actionPerformed(ActionEvent e){
			if(Snake.getTouch()==true||sNakes.isHickSelf()==true){//撞到	墙、自己、鸟
				sNakes.Food.hide();
				sNakes.Food = null;
				timer.stop();
				timer = null;
				oBtnPlay.setEnabled(false);
				String strl = new String();
				strl = readfile();
				if(oLblSnakeLen.getText().length()==strl.length())
					if(oLblSnakeLen.getText().compareTo(readfile())<=0)
						JOptionPane.showMessageDialog(null, "死翘翘喽~~~~继续加油哦^_^");
					else
					{
						writefile();
						oLblSnakeLen2.setText(Integer.toString(sNakes.iLen));
						JOptionPane.showMessageDialog(null, "You are the record breaker !\n     please leave you name\n                     ^_^");
					}
				else if(oLblSnakeLen.getText().length()<strl.length())
						JOptionPane.showMessageDialog(null, "死翘翘喽~~~~继续加油哦^_^");
				else
				{
					writefile();
					oLblSnakeLen2.setText(Integer.toString(sNakes.iLen));
					JOptionPane.showMessageDialog(null, "You are the record breaker !\n     please leave you name\n                     ^_^");
				}
/*



				if(oLblSnakeLen.getText().length()>readfile().length)
				{
					writefile();
					oLblSnakeLen2.setText(Integer.toString(sNakes.iLen));
					JOptionPane.showMessageDialog(null, "You are the record breaker !\n     please leave you name\n                     ^_^");
			
				}
				else if(oLblSnakeLen.getText().compareTo(readfile())>0){
					writefile();
					oLblSnakeLen2.setText(Integer.toString(sNakes.iLen));
					JOptionPane.showMessageDialog(null, "You are the record breaker !\n     please leave you name\n                     ^_^");
				}
				else
					JOptionPane.showMessageDialog(null, "死翘翘喽~~~~继续加油哦^_^");

*/
				return;
			}
			else{
				sNakes.move();
			}
        }
    }
	public void stop(){
        if(timer != null){
            if(timer.isRepeats())
                timer.stop();
            timer = null;
        }
    }
	public void writefile(){
		String str = Integer.toString(sNakes.iLen);
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter("sankegame.db"));
			out.write(str);
			out.close();
		} catch (IOException e) {
		}
	}
	public String readfile(){//change it to int
		String str = new String();
		try {
			BufferedReader in = new BufferedReader(new FileReader("sankegame.db"));
			str = in.readLine();
			in.close();
			System.out.println(str);
		} catch (IOException e) {
		}
		return str;//``````````
	}


	public static void main(String[] args){
		SnakeGame oSnakeGame = new SnakeGame(); 
		JFrame frame = new JFrame("贪食蛇");
		frame.getContentPane().add(oSnakeGame);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		oSnakeGame.init();
		oSnakeGame.start();
		frame.setSize(310, 340);
		frame.setLocation(300,200);
		frame.setVisible(true);
		frame.setResizable(false);
	}
}
