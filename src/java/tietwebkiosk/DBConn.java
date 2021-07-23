package tietwebkiosk;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DBConn 
{
	Connection con;
	public Connection DBConOpen()
	{
		try
		 {
			Context cnt = new InitialContext();
			Context Env = (Context)cnt.lookup("java:/comp/env");
			DataSource ds = (DataSource)Env.lookup("jdbc/webkioskdb");
			con = ds.getConnection();	
		 }
			catch(Exception e)
			{
			 //e.printStackTrace();
			}
	return con;
	}

	public void DBConClose()
	{
		try
		 {
			con.close();
		 }
		 catch(Exception e)
			{
			  
			 //e.printStackTrace();
			}
			finally
				{
					try
						{
							con.close();
						}
					 catch(Exception e)
						{}
				}
	}
}
