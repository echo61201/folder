import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.*;

 class DelData {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Moneymanager m = new Moneymanager();
	String j=JOptionPane.showInputDialog("请输入需要删除的行序号:");
	public  Integer i=Integer.valueOf(j);
	
public DelData(){
	new Show().getplayerInfo();
	if(i>new Show().xuhao||i<1){JOptionPane.showMessageDialog(null,"没有第"+i+"行记录!!!!");}
	else{
	//System.out.println(txt1.getText());	
	//删除操作
	try{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//安装驱动
		}catch(java.lang.ClassNotFoundException e){
				System.out.println("forname:　" + e.getMessage());
		}
	try{
		Connection c = DriverManager.getConnection("jdbc:odbc:STU");//连接数据库
		Statement s = c.createStatement();
		PreparedStatement p1 = c.prepareStatement("delete from Moneymanager where 序号=?");
		PreparedStatement p2 = c.prepareStatement("UPDATE Moneymanager set 序号=? where 序号=?");
		p1.setInt(1, i);
		p1.executeUpdate();
		ResultSet rs=s.executeQuery("select * from Moneymanager");
		int k=1;
		while(rs.next()){
		  if(k>=i&&k<=new Show().xuhao){
			p2.setInt(1,k);
			p2.setInt(2,k+1);
			p2.executeUpdate();
		  }
			k++;
		}
		Moneymanager.m.f5();
		int l=0;
		for(l=0;l<4;l++)
		Moneymanager.m.table.setValueAt("", k-1,l );
		
		p1.close();p2.close();
		s.close();c.close();
		JOptionPane.showMessageDialog(null,"删除第"+i+"行数据成功！！    ");
	}catch(SQLException e){
	System.out.println("SQLException: "+ e.getMessage());	
    	}      
}	
}
	
	public static void main(String[] args) {
		//new DelData();
	}

}
