import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;


 class Tongji extends JFrame implements ActionListener{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static JFrame f = new JFrame("财务统计");
	static JLabel lb1 = new JLabel("您的余额为：");
	static JLabel lb2 = new JLabel("");
	static JButton bt1 = new JButton("确定");
	
	public String getlb2(){
		int i=0,k=0;
		 
		try {
		    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); //加载access数据库驱动
		   } catch (ClassNotFoundException e1) {
		    e1.printStackTrace();
		   }
		   try{
		   Connection conn = DriverManager.getConnection("jdbc:odbc:STU"); //建立连接这里student为数据库名
		   Statement stmt = conn.createStatement();
		   ResultSet rs=stmt.executeQuery("select * from Moneymanager");//将查询得到的结果集给rs
		   
		   
		   while(rs.next()){
			   i=i+rs.getInt("收入");
			   k=k+rs.getInt("支出");
		   }
		  
		   }catch(SQLException e1){
		   e1.getStackTrace();
		   }   
		
		   
		//余额
		
		return String.valueOf(i-k)+"元";
	}
	Tongji(){
		f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		   f.setBounds(370, 200,300,200); //主窗口大小
		   f.setLayout(null);f.setResizable(false);
		   
		   bt1.setBounds(110, 110, 60, 30);f.add(bt1);bt1.addActionListener(this);
			lb1.setBounds(75, 27, 160, 20);f.add(lb1);
			lb1.setFont(new Font("Serif",Font.BOLD,18));
			lb2.setText(getlb2());
			lb2.setBounds(120, 70, 160, 20);f.add(lb2);
			lb2.setFont(new Font("Serif",Font.BOLD,24));
			f.setVisible(true);
	}

	
	public void actionPerformed(ActionEvent   e){
		f.setVisible(false);
		
	}
	
	public static void main(String[] args) {
		//new Tongji();
	}

}
