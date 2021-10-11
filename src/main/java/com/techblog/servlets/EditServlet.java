package com.techblog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;

@MultipartConfig			/* To process any kind of data like image or anything write this*/
public class EditServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		
		String userName = request.getParameter("user_name");
		String userAbout = request.getParameter("user_about");
		
		// To get image from jsp
		Part part = request.getPart("image");
		String imageName = part.getSubmittedFileName();
		
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		
		user.setName(userName);
		user.setAbout(userAbout);
		
		String oldFile = user.getProfile();
		user.setProfile(imageName);
		
		//update in database
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		boolean isUpdated = userDao.updateUser(user);
		
		if(isUpdated)
		{
			String newFilePath = request.getRealPath("/")+"pics"+File.separator+user.getProfile();
			
			String oldFilePath = request.getRealPath("/")+"pics"+File.separator+oldFile;
			
			//this will stop default.png from being deleted
			if(!oldFile.equals("default.png")) {
				Helper.deleteFile(oldFilePath);
			}
					
			
				if(Helper.saveFile(part.getInputStream(), newFilePath))
				{
					out.println("Profile updated");
					Message msg = new Message("Profile updated","success","alert-success");

					session.setAttribute("msg", msg);
					
				}		
		}
		else
		{
			out.println("not updated");
			Message msg = new Message("Something went wrong!!","error","alert-danger");

			session.setAttribute("msg", msg);
		}
		
		response.sendRedirect("profile.jsp");
	}

}
