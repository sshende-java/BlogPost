package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;


@MultipartConfig   /* To process any kind of data like image or anything write this*/
public class RegisterServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
			PrintWriter out = response.getWriter();
			
			String check = request.getParameter("check");
			if(check==null)
			{
				out.println("Please check terms and conditions");
			}
			else
			{
				String name = request.getParameter("user_name");
				String email = request.getParameter("user_email");
				String password = request.getParameter("user_password");
				String about = request.getParameter("user_about");
				
				User user = new User(name, email, password, about);
				
				UserDao userDao = new UserDao(ConnectionProvider.getConnection());
				if(userDao.saveUser(user))
				{
					out.println("done");
				}
				else
				{
					out.println("error");
				}
			}
	}

}
