/**
 * 此Changepw.class用于修改程序密码；
 * 
 * 
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.swing.*;

 class Changepw {
	/**
	 * 
	 */
	 String j =	JOptionPane.showInputDialog("请输入原密码:");
	
	public  Changepw(){
		if(j.equals(new GetOldPW().getpw())){
			String k =	JOptionPane.showInputDialog("请输入新密码:");
			String l =	JOptionPane.showInputDialog("请确认新密码:");
			if(l.equals(k)){
				try{
					Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//安装驱动
				}catch(java.lang.ClassNotFoundException e){
					System.out.println("forname:　" + e.getMessage());
				}
				try{
					Connection c = DriverManager.getConnection("jdbc:odbc:STU");//连接数据库
					PreparedStatement s = c.prepareStatement("UPDATE pw set password=?");
					s.setString(1, l);
					s.executeUpdate();
					
					 s.close();
					c.close();
					JOptionPane.showMessageDialog(null,"密码修改成功！！");
				}catch(SQLException e){
					System.out.println("SQLException: "+ e.getMessage());	
					}
				
				
				
			}else
			JOptionPane.showMessageDialog(null,"两次输入密码不同！修改失败！！");
			
		}else
			JOptionPane.showMessageDialog(null,"密码错误！！修改失败！！  ");
		}
	
	public static void main(String[] args) {
					
		}
	}