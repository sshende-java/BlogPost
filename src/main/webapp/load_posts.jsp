<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page errorPage="error_page.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<!-- This page will load initially for profile page of user -->
<div class="row">

		<%
			PostDao postDao = new PostDao(ConnectionProvider.getConnection());
			int cid = Integer.parseInt(request.getParameter("cid"));
			List<Post> posts = null;
			if(cid==0){
				posts = postDao.getAllPosts();	
			}
			else{
				posts = postDao.getPostByCatId(cid);
			}
		
			
			for (Post p : posts) {
		%>
<!-- 			Card to show posts -->
			<div class="col-md-6 mt-2">
				<div class="card">
					<img class="card-img-top" width="200" height="200" src="blogpics/<%=p.getpPic() %>" alt="Card image cap">
					<div class="card-body">
						<b><%=p.getpTitle() %></b>
						<p><%=p.getpContent().substring(0, 145)+"...<b>more</b>"  %></p>
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
</body>
</html>