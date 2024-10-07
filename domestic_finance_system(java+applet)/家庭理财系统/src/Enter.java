import  java.awt.event.*;
import javax.swing.*;

 public class Enter extends JFrame   implements ActionListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static JFrame f1 = new JFrame("家庭理财系统");
	 static JButton bt1 = new JButton("登入");
	 static JButton bt2 = new JButton("退出");
	 static JLabel lb1 = new JLabel("请输入密码: ");
	 static JPasswordField pw = new JPasswordField();
	 
	public Enter (){
		   f1.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		   f1.setLayout(null);
		   f1.setBounds(300, 200, 300, 200);
		   f1.setResizable(false);
		   bt1.setBounds(60, 100, 60, 30);
		   bt2.setBounds(160, 100, 60, 30);		   
		   lb1.setBounds(60, 30, 200, 20);
		   pw.setBounds(60, 60, 150, 25);
		   f1.add(bt1);bt1.addActionListener(this);
		   f1.add(bt2);	bt2.addActionListener(this);
		   f1.add(lb1);
		   f1.add(pw);	
		   f1.setVisible(true);
	}
	
	public void actionPerformed(ActionEvent   e)
	  {
	   String a,b;
	   a=new String (pw.getPassword());
	   b=new GetOldPW().getpw();
	   	if(e.getSource()==bt1)
	     {			
		   if(a.equals(b)){
			   f1.setVisible(false);
			   
			   Moneymanager.m.MoneymanagerWindow();
			  // new Moneymanager().MoneymanagerWindow();
			   
			   
		   }
		   else 
		   { pw.cut();//错误声音提示
		   JOptionPane.showMessageDialog(null,"密码错误，请重新输入密码 ！      ");
		   }
		       			 	       
	     }
	   else if(e.getSource()==bt2){
		   System.exit(0);
	    }
	}
/**
	public static void main(String[] args) {
	//	      new Enter();
     }
**/
}
