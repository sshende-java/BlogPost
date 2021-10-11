package com.techblog.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techblog.dao.PostDao;
import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

/**
 * Servlet implementation class DeletePostServlet
 */
public class DeletePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
   		HttpSession session = request.getSession();
   		User user = (User)session.getAttribute("currentUser");
   		int postId = (Integer)session.getAttribute("post_id");
   		
   		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		
   		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		if(dao.deletePost(postId))
		{
			response.sendRedirect("profile.jsp");
		}
		else {
			response.sendRedirect("show_blog_page.jsp?post_id="+postId);
		}
	}

	
}
