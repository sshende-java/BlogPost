package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.techblog.entities.Category;
import com.techblog.entities.Post;

public class PostDao {

	private Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
	}
	
	//Return All Categories
	public ArrayList<Category> getAllCategories()
	{
		ArrayList<Category> list = new ArrayList<Category>();
		
		try {		
			String query = "select * from categories";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			while(rs.next())
			{
				int cid = rs.getInt("cid");
				String name = rs.getString("name");
				String description = rs.getString("description");
				
				Category c = new Category(cid,name,description);
				
				list.add(c);
			
			}		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return list;	
	}
	
	//Add Post in posts table
	public boolean savePost(Post p)
	{
		boolean f=false;
		try
		{
			String query="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());
			pstmt.executeUpdate();
			f = true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return f;
	}

	
	//Get All Posts
	public List<Post> getAllPosts()
	{
		List<Post> list = new ArrayList<Post>();
		
		try {
			String query="select * from posts order by pid desc";
			PreparedStatement pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");
				
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
				list.add(post);
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	//Get post by category Id
	public List<Post> getPostByCatId(int catId)
	{
		List<Post> list = new ArrayList<Post>();
		
		try {
			String query="select * from posts where catId=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1,catId);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int userId = rs.getInt("userId");
				
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
				list.add(post);
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		

		
		return list;
	}
	
	//To get Single Post using postId
	public Post getPostByPostId(int postId)
	{
		Post post = null;
		try {
			String query = "select * from posts where pid=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1,postId);	
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())
			{
				int pid = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp date = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");
				
				post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return post;
		
	}


	//Load First 6 posts for Index page
	public List<Post> getIndexPosts()
	{
		List<Post> list = new ArrayList<Post>();
				
				try {
					String query="select * from posts order by pid desc	limit 6";
					PreparedStatement pstmt = con.prepareStatement(query);
					ResultSet rs = pstmt.executeQuery();
					
					while(rs.next()) {
						
						int pid = rs.getInt("pid");
						String pTitle = rs.getString("pTitle");
						String pContent = rs.getString("pContent");
						String pCode = rs.getString("pCode");
						String pPic = rs.getString("pPic");
						Timestamp date = rs.getTimestamp("pDate");
						int catId = rs.getInt("catId");
						int userId = rs.getInt("userId");
						
						Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
						list.add(post);
					}
					
				}catch(Exception e)
				{
					e.printStackTrace();
				}
				
				
				return list;
	}
	
	
	//Delete Post
	public boolean deletePost(int postId)
	{
		boolean f =false;
		try {
			String query = "delete from posts where pid= ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1,postId);
			pstmt.executeUpdate();
			f=true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return f;
	}
}

