<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="error_page.jsp"
	isELIgnored="false"%>
<%@ page errorPage="error_page.jsp" %>
<%
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");

	//check if user is logged in or not
	User user = (User) session.getAttribute("currentUser");
	if (user == null) {
		response.sendRedirect("login.jsp");
	}
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<link rel="stylesheet" href="css/mystyle.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />



<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<body>

	<!-- navbar start -->

	<nav
		class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
	<a class="navbar-brand" href="index.jsp"><span
		class="fa fa-snowflake-o"></span> BlogPost</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="#">Home
					<span class="sr-only">(current)</span>
			</a></li>


			<li class="nav-item"><a class="nav-link" href="#" onclick="contactfun()"><span
					class="fa fa-address-card-o"></span> Contact</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal" ><span class="fa fa-bell-o"></span> Add Post</a>
			</li>
		</ul>
		<ul class="navbar-nav mr-right">
			<li class="nav-item"><a class="nav-link" href="#!"
				data-toggle="modal" data-target="#profile-modal"><span
					class="fa fa-user-circle"></span> <%=user.getName()%> </a></li>
			<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
					class="fa fa-window-close"></span> Logout</a></li>
		</ul>


	</div>
	</nav>


	<!-- navbar ends -->


	<%
		Message msg = (Message) session.getAttribute("msg");
		if (msg != null) {
	%>
	<div class="alert <%=msg.getCssClass()%>" role="alert">
		<%=msg.getContent()%>
	</div>
	<%
		session.removeAttribute("msg");
		}
	%>

	<!-- Main body of page -->
	
		<main>
			<div class="container">
				<div class="row mt-4">
				
					<!-- First Col -->
					<div class="col-md-4">
					
						<!--categories -->
							<div class="list-group">
							  <a href="#" onclick="getPosts(0)" class="list-group-item list-group-item-action active">
							    All Posts
							  </a>
							  <%
							  	PostDao pd = new PostDao(ConnectionProvider.getConnection());
							  	ArrayList<Category> list1= pd.getAllCategories();
							  	for(Category cc: list1)
							  	{
							  	%>
                            <!--    	getPosts() is nothing but javascript function to load posts using ajax  -->
									  <a href="#" onclick="getPosts(<%=cc.getCid() %>)" class="list-group-item list-group-item-action"><%=cc.getName() %></a>  	
							  	<% 	
							  	}
							  
							  %>
							
							</div>						
						
					</div>
					
					<!-- Second Col -->
					<div class="col-md-8">
						<!--posts -->
						<div class="container text-center" id="loader">
							<i class="fa fa-refresh fa-3x fa-spin"></i>
							<h3 class="mt-2">Loading..</h3>
						</div>
						
						<div class="container-fluid" id="post-container">
                    <!-- 		Either loader or post-container will display one at a time but not both -->
					<!-- 		We are populating post container with data fetched from load_posts.jsp -->	
						</div>
					
					</div>
									
				</div>
			
			</div>
		
		</main>
	
	
	<!-- End Main body of page -->

	<!-- Profile modal -->
	<!-- Modal -->
	<!-- If you click on Your name from navbar it will run this predefined Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">BlogPost</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img height="200" width="150" src="pics/<%=user.getProfile()%>"
							class="img-fluid" style="border-radius: 50%"> <br>
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

						<!--############# User Details ########## -->

						<div id="profile-details">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Status:</th>
										<td><%=user.getAbout()%></td>

									</tr>
									<tr>
										<th scope="row">Registered on:</th>
										<td><%=user.getDateTime().toString()%></td>

									</tr>
								</tbody>
							</table>
						</div>

			<!-- Profile Edit -->

						<div id="profile-edit" style="display: none;">
							<h6 class="mt-2">Please Edit Carefully</h6>

							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Name</td>
										<td><input class="form-control" type="text"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>Email</td>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<td>Status</td>
										<td><textarea rows="3" cols="" class="form-control"
												name="user_about"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<td>New Profile</td>
										<td><input type="file" name="image" class="form-control">
										</td>
									</tr>
								</table>

								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>

							</form>

						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>


	<!-- End of Profile modal -->


<!--  #######	 ADD Post Modal		####### -->
<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add Post</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">	<!--  Inserting Form in Modal Body	-->
        
        <form id="add-post-form" action="AddPostServlet" method="post">
        	
        	<div class="form-group">
        		<select class="form-control" name="cid">
        			<option selected disabled>-----Select Category------</option>
        			
        			<% 
        				PostDao postDao = new PostDao(ConnectionProvider.getConnection());
        				ArrayList<Category> list =  postDao.getAllCategories();
        				
        				for(Category c: list)
        				{
        			%>
        					<option value="<%=c.getCid() %>"><%=c.getName() %></option>
        			<%
        				}
        			%>
        			
        		</select>
        	</div>
        	<div class="form-group">
        		<input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control" />
        	</div>
        	<div class="form-group">
        		<textarea  name="pContent" class="form-control" placeholder="Enter Content Here" style="height:200px;"></textarea>
        	</div>
        	<div class="form-group">
        		<textarea  name="pCode" class="form-control" placeholder="Enter Code Snippet Here" style="height:200px;"></textarea>
        	</div>
        	<div class="form-group">
        		<input type="file" name="pic" class="form-control" />
        	</div>
			<div class="container text-center">
				<button type="submit" class="btn btn-outline-primary">Post</button>
			</div>
        </form>
        
      </div>
      
    </div>
  </div>
</div>

<!--  #######	 End ADD Post Modal		####### -->


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
		
		
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script> 

	<!-- 		To toggle edit and back buttons using JQuery -->
	<script type="text/javascript">
		$(document).ready(function() {

			let editStatus = false;

			$('#edit-profile-button').click(function() {
				if (editStatus == false) {
					$("#profile-details").hide()

					$("#profile-edit").show()
					editStatus = true;
					$(this).text("Back")
				} else {
					$("#profile-details").show()

					$("#profile-edit").hide()
					editStatus = false;
					$(this).text("Edit")
				}
			})
		});
	</script>
	
	<!-- Now 'Add Post' js -->
	<script>
		$(document).ready(function(e){
			
			$("#add-post-form").on("submit",function(event){
				//this code gets called when user tries to Add Post
				event.preventDefault();
				
				let form = new FormData(this);
				
				//send data to AddPostServlet
				$.ajax({
					url:"AddPostServlet",
					type:'POST',
					data:form,
					success: function(data,textStatus,jqXHR){
	  					console.log(data);	//here data coming from AddPostServlet in out.println()
	  					
	  					if(data.trim()=="done")
	  					{
	  						swal("Good job!", "Post Added Successfully", "success");	//sweetalert cdn
	  					}
	  					else{
	  						swal("Error!", "Something went wrong try again...", "error");
	  					}
					},
					error: function(jqXHR,textStatus,errorThrown){
						swal("Error!", "Something went wrong try again...", "error");
					},
					processData:false,
	  				contentType:false
					
				})
			})
		});
	</script>
	
<!-- 	Load posts using ajax -->
	<script>
		
		function getPosts(catId){
			$("#loader").show();
			$("#post-container").hide();
			
			$.ajax({
				url:"load_posts.jsp",
				data:{cid:catId},   /* Sending cid as key-parameter and catId as value of cid to load_posts.jsp (key:value) */
				success: function(data,textStatus,jqXHR){  /* On this line data means data displayed on load_posts.jsp */
					console.log(data);
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);      /* populating post-container div with data from load_posts.jsp */
				}
			})
		}
	
	
		$(document).ready(function(e){
			getPosts(0)			

			
		})
	</script>
	
<!-- 	For contact click -->
	<script type="text/javascript">
		function contactfun(){
			swal("Contact Us at saurabh.shende25@gmail.com");
		}	
	
	</script>

</body>
</html>