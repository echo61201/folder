/**
 *此Sql.class用于测试，学习java对数据库的操作。。
 *不包含在程序中 
 *
 * 
 * */

import java.sql.*;
  class Sql{

public  Sql(){
	try{
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//安装驱动
	}catch(java.lang.ClassNotFoundException e){
		System.out.println("forname:　" + e.getMessage());
	}
	try{
		Connection c = DriverManager.getConnection("jdbc:odbc:STU");//连接数据库
		Statement s = c.createStatement();//查询的时候要用
		//PreparedStatement p1 = c.prepareStatement("UPDATE consumer set tatalmoney=? Where id=?");
		
		//ResultSet rs = s.executeQuery("select * from consumer");
		
		//s.executeUpdate("create table consumer(id char(10),name char(15),tatalmoney integer)");
		//String shouru = Moneymanager.txt1.getText();
	    //s.executeUpdate("insert into maneymanager values('5','"+shouru+" ','1231','6','6')");//添加数据
	    //p1.setInt(1,55);p1.setString(2,"123");p1.executeUpdate();p1.close();//修改数据
	    //while(rs.next()){
	    	//System.out.println(rs.getString("id")+rs.getString("name"));
	    //}
	    		    	    	    
	    s.close();
		c.close();
	}catch(SQLException e){
		System.out.println("SQLException: "+ e.getMessage());	
		}

}

	


	public static void main(String[] args){
		//new Sql();
		
	}
}
		
