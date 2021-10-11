package com.techblog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techblog.entities.Message;

/**
 * Servlet implementation class LogoutServlet
 */
public class LogoutServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	HttpSession session = request.getSession();
	session.removeAttribute("currentUser");
	Message msg = new Message("Logout successfully","success","alert-success");
	session.setAttribute("msg", msg);
	response.sendRedirect("login.jsp");
	
	}

}
