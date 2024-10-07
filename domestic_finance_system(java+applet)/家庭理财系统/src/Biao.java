 import javax.swing.*;

 import java.awt.*;
 import java.awt.event.*;

  class Biao implements  ActionListener{
	// JPanel f=new JPanel();
 	 JFrame f = new JFrame("家庭理财系统");
	 String[] Names={"序号","收入","支出","时间","备注"};
	 //String[][] playerInfo= new String[10000][5];
	 //Object[][] playerInfo={};
	 JTable table=new JTable(new Show().playerInfo,Names);
	 //JTable table=new JTable(new Show().xuhao+5,5);
	 //JTable table=new JTable(5,5);
	 JScrollPane s=new JScrollPane(table);
	 static JPanel p = new JPanel();
	 static JButton bt1 = new JButton("修改密码");
	 public Biao(){
		 // new Show().getplayerInfo();
		 p.setBounds(20,105,800,410);
		 f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		   f.setBounds(100, 50, 849, 600); //主窗口大小
		   f.setLayout(null);f.setResizable(false);
		 table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
		 p.add(s);f.add(p);
		 bt1.setBounds(5,5,200,40);f.add(bt1);bt1.addActionListener(this);
	      table.setPreferredScrollableViewportSize(new Dimension(770,370));
	     // table.setValueAt("12", 1, 1);
	   f.setVisible(true);
	      
	 }
	
	 public void actionPerformed(ActionEvent   e){
			
			//	new Show().fff();
		 table.setValueAt("12", 1, 4);	
			}

 public static void main(String[] args){
      new Biao();
     
 }
 }