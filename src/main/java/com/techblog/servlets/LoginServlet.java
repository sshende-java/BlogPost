package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out = response.getWriter();
		
		String email = request.getParameter("email");
		String password  = request.getParameter("password");
		
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		User u = userDao.getUserByEmailAndPassword(email,password);
		
		if(u==null)
		{
			Message msg = new Message("Invalid Credentials!!","error","alert-danger");
			HttpSession session = request.getSession();
			session.setAttribute("msg", msg);
			response.sendRedirect("login.jsp");
		}
		else
		{
			HttpSession session = request.getSession();
			session.setAttribute("currentUser",u);
			response.sendRedirect("profile.jsp");
			
			
		}
		
		
	}

}
