import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

 class Help extends JFrame implements ActionListener{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static JFrame hp = new JFrame("家庭理财系统帮助");
	static JPanel help = new JPanel();
	static JButton bt = new JButton("退出");
	static JLabel lb1 = new JLabel("帮助：");
	static JLabel lb2 = new JLabel("  1、 修改密码：单击修改密码，则直接输入新的密码，然后确定就可以了;");
	static JLabel lb3 = new JLabel("  2、 修改数据：单击修改数据，然后选择要修改的对象的序号，再按需要修改;");
	static JLabel lb4 = new JLabel("  3、 删除数据：单击删除数据，然后选择要删除的对象的序号，直接点击删除;");
	static JLabel lb5 = new JLabel("  4、 财务统计：单击统计，可以按照给定的规则处理，可以按照某一时间进行统计;");
	static JLabel lb6 = new JLabel("  5、 总结余——显示的是最后的总计，与现款直接对应，简单明了;");
	static JLabel lb7 = new JLabel("  6、 程序的初始密码为:123；");
	static JLabel lb8 = new JLabel("  7、 单击添加，则可以在该行右边直接按次序输入财务信息；");
	static JLabel lb9 = new JLabel("  8、 本程序为潘海强和钟余洋开发，望大家多多提些建议。");
		
		public  Help(){
		hp.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		help.setLayout(null);hp.setLayout(null);
		hp.setBounds(270, 180, 520, 300);
		help.setBounds(0, 0, 520, 200);
		hp.setResizable(false);
		bt.setBounds(150, 220, 200, 40);	hp.add(bt);	bt.addActionListener(this);
		lb1.setBounds(15, 20, 600, 20);help.add(lb1);	
		lb2.setBounds(15, 40, 600, 20);help.add(lb2);
		lb3.setBounds(15, 60, 600, 20);help.add(lb3);
		lb4.setBounds(15, 80, 600, 20);help.add(lb4);
		lb5.setBounds(15, 100, 600, 20);help.add(lb5);
		lb6.setBounds(15, 120, 600, 20);help.add(lb6);
		lb7.setBounds(15, 140, 600, 20);help.add(lb7);
		lb8.setBounds(15, 160, 600, 20);help.add(lb8);
		lb9.setBounds(15, 180, 600, 20);help.add(lb9);
		hp.add(help);
		hp.setVisible(true);
		help.setVisible(true);
		
	}
		
		public void actionPerformed(ActionEvent   e){
			hp.setVisible(false);
		}
	public static void main(String[] args) {
		//new Help();
	}

}
