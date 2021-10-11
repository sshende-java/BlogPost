package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.techblog.entities.Post;
import com.techblog.entities.User;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		super();
		this.con = con;
	}
	
	public boolean saveUser(User user)
	{
		boolean f = false;
		try {
					
			String query ="insert into user(name,email,password,about) values(?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getAbout());
			pstmt.executeUpdate();
			f=true;
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return f;
	}
	
	
	
	//get user with email and password
	public User getUserByEmailAndPassword(String email,String pwd) {
		
		User user=null;
		
		try {
			String query="select * from User where email=? and password=?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, pwd);
			ResultSet rs =pstmt.executeQuery();
			
			if(rs.next()) 
			{
				user = new User();
				String name = rs.getString("name");
				user.setName(name);
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate"));
				user.setProfile(rs.getString("profile"));
				
			}
			
		}
		catch(Exception e)
		{
			System.out.println("error in getUserByEmailAndPassword");
		}
		
		return user;
	}
	
	//Update User in db
	public boolean updateUser(User user)
	{
		boolean f=false;
		try
		{
			String query="update user set name=?,about=?,profile=? where id=?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getAbout());
			pstmt.setString(3, user.getProfile());
			pstmt.setInt(4, user.getId());
			pstmt.executeUpdate();
			f=true;
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return f;
	}
	
	public User getUserByPostId(int userId)
	{
		User user=null;
		
		try {
			String query="select * from user where id=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				
				user = new User();
				String name = rs.getString("name");
				user.setName(name);
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate"));
				user.setProfile(rs.getString("profile"));
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return user;
	}
	
}
