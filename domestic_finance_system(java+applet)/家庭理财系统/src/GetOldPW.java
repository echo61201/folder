import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


 class GetOldPW {
	String oldpw;
	public String getpw(){
		
		try{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//安装驱动
		}catch(java.lang.ClassNotFoundException e){
			System.out.println("forname:　" + e.getMessage());
		}
		try{
			Connection c = DriverManager.getConnection("jdbc:odbc:STU");//连接数据库
			Statement s = c.createStatement();
			ResultSet rs = s.executeQuery("select * from pw");
			while(rs.next()){
				oldpw=rs.getString("password");
					}
			 s.close();
			c.close();
				}catch(SQLException e){
			System.out.println("SQLException: "+ e.getMessage());	
			}
		return oldpw;
	}
}
