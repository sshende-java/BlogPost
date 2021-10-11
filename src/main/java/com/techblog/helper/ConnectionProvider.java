package com.techblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

	private static Connection con;
	public static Connection getConnection()
	{
		String url="jdbc:mysql://localhost:3306/techblog";
		String user="root";
		String pass="root";
		try {
			
			if(con==null)
			{
				//load driver class
				Class.forName("com.mysql.jdbc.Driver");
				
				//create connection
				con = DriverManager.getConnection(url,user,pass);
			}
			
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		
		return con;
	}
	
	
}
