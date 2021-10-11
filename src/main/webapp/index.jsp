<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.User"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate"); 
	
	//check if user is logged in or not
	User user = (User) session.getAttribute("currentUser");
	if (user != null) {
		response.sendRedirect("profile.jsp");
	}
	
	PostDao postDao = new PostDao(ConnectionProvider.getConnection());
	List<Post> posts = postDao.getIndexPosts();

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- css -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<link rel="stylesheet" href="css/mystyle.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Index page</title>

</head>
<body>

	<!-- navbar -->
	<%@ include file="normal_navbar.jsp"%>


	<!-- Banner -->
	<div class="container-fluid p-0 m-0">

		<div class="jumbotron primary-background text-white">

			<div class="container">
				<h3 class="display-3">Introduction</h3>
				<p>Welcome to BlogPost ,world of technology A programming
					language is a formal language comprising a set of instructions that
					produce various kinds of output. Programming languages are used in
					computer programming to implement algorithms.</p>

				<a href="register_page.jsp" class="btn btn-outline-light ">
					<span class="fa fa-user-plus"></span> Register
				</a>
				&nbsp;
				<a href="login.jsp" class="btn btn-outline-light ">
					<span class="fa fa-user-circle-o"></span> Login
				</a> 

			</div>

		</div>

	</div>

	<!-- cards -->
	<div class="container">
		<div class="row mb-4">
		<%
			/*Line 18 and 19 will be used here */
			for (Post p : posts) {
		%>
<!-- 			Card to show posts -->
			<div class="col-md-4 mt-2">
				<div class="card">
					<img class="card-img-top" width="200" height="200" src="blogpics/<%=p.getpPic() %>" alt="Card image cap">
					<div class="card-body">
						<b><%=p.getpTitle() %></b>
						<p><%=p.getpContent().substring(0, 145)+"...<b>more</b>" %></p>
					</div>
					<div class="card-footer">
						<a href="show_blog_page.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-primary btn-sm" >Read More..</a>
					</div>
			
				</div>
			</div>

		<%
			}
		%>
			
		</div>
				

	</div>


	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>




</body>
</html>