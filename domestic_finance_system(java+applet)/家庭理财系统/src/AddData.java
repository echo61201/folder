import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement; 

import javax.swing.JOptionPane;
  class AddData{

public  AddData(){
	try{
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//安装驱动
	}catch(java.lang.ClassNotFoundException e){
		System.out.println("forname:　" + e.getMessage());
	}
	try{
		Connection c = DriverManager.getConnection("jdbc:odbc:STU");//连接数据库
		Statement s = c.createStatement();
		Integer shouru = Integer.valueOf(Moneymanager.txt1.getText());
		Integer zhichu = Integer.valueOf(Moneymanager.txt2.getText());
		String shijian = Moneymanager.txt3.getText();
		String beizhu = Moneymanager.txt4.getText();
		
		if(!shouru.equals(0)||!zhichu.equals(0)){
			new Show().getplayerInfo();	
			s.executeUpdate("insert into Moneymanager(序号,收入,支出,时间,备注)  values('"+(new Show().xuhao+1)+"','"+shouru+"','"+zhichu+"','"+shijian+"','"+beizhu+" ')");//添加数据
			Moneymanager.txt1.setText("0");Moneymanager.txt2.setText("0");
			Moneymanager.txt4.setText(" ");
			 }
		else
			JOptionPane.showMessageDialog(null,"请输入收入或支出 ！   ");
			s.close();
		    c.close();
	}catch(SQLException e){
		System.out.println("SQLException: "+ e.getMessage());	
		}
	//new Moneymanager().f5();

}

public static void main(String[] args){
		//new AddData();
	//new Moneymanager().f5();
	}
}
		
