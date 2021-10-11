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

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		
		int cid = Integer.parseInt(request.getParameter("cid"));
		
		//Get user from session because we need id of user whom this post belong
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		
		
		String pTitle = request.getParameter("pTitle");
		String pContent = request.getParameter("pContent");
		String pCode = request.getParameter("pCode");
		
		Part part = request.getPart("pic");
		String imageName = part.getSubmittedFileName();
		
		
		Post post = new Post(pTitle, pContent, pCode, imageName, null, cid, user.getId());
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		if(dao.savePost(post))
		{
			
			String newFilePath = request.getRealPath("/")+"blogpics"+File.separator+imageName;
			Helper.saveFile(part.getInputStream(), newFilePath);
			out.println("done");
		}
		else
		{
			out.println("error");
		}
		
	}

}
