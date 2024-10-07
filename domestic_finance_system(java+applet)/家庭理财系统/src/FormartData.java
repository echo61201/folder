
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.swing.JOptionPane;


 class FormartData {
	
	public FormartData(){
		int r=new Show().xuhao;
						try{
						Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//安装驱动
					}catch(java.lang.ClassNotFoundException e){
						System.out.println("forname:　" + e.getMessage());
					}
					try{
						Connection c = DriverManager.getConnection("jdbc:odbc:STU");//连接数据库
						PreparedStatement p = c.prepareStatement("delete from Moneymanager");
						p.executeUpdate();
						p.close();
						c.close();
						}catch(SQLException e){
						System.out.println("SQLException: "+ e.getMessage());	
						} 
						int m=0,n=0;
						
						for(m=0;m<r;m++)
							for(n=0;n<4;n++){
						Moneymanager.m.table.setValueAt("", m,n);
							}
						Moneymanager.m.f5();
					JOptionPane.showMessageDialog(null,"数据已成功清空！！    ");
					
						
		}
		
public static void main(String[] args) {
		//new FormartData();
	}

}

