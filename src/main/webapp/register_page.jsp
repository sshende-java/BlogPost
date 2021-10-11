<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"  errorPage="error_page.jsp" %>
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
<title>Insert title here</title>
</head>
<body>

	<!-- navbar -->
	<%@ include file="normal_navbar.jsp"%>

	<main class="p-5" >
	<div class="container">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header">
						<span class="fa fa-user-circle-o fa-3x"></span>
						<p>Register Here</p>
					</div>
					<div class="card-body">
<form id ="myform" action="RegisterServlet" method="post">
  <div class="form-group">
    <label for="user_name">User Name</label>
    <input type="text" name="user_name" class="form-control" id="user_name" placeholder="Enter Name">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input type="email" name="user_email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" name="user_password" class="form-control" id="exampleInputPassword1" placeholder="Password">
  </div>
  <div class="form-group">
   <textarea name="user_about" class="form-control" rows="5" cols="5" placeholder="Enter something about yourself..."></textarea>
  </div>
  <div class="form-check">
    <input type="checkbox" class="form-check-input" id="exampleCheck1" name="check" required>
    <label class="form-check-label" for="exampleCheck1">Agree to terms and conditions</label>
  </div><br>
  <button type="submit" class="btn btn-primary">Sign Up</button>
  <h6 id="msg" style="display:none;color:green;text-align:left;margin-top: 8px"></h6>

</form>
					</div>
					</div>
			
			</div>
		</div>
	</div>
</main>







	<!-- Javascript and Jquery -->
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


<script>
  	$(document).ready(function(){
  		console.log("loaded....")
  		
  		$("#myform").on('submit',function(event){
  			event.preventDefault();
  			
  			let form = new FormData(this);
  			
  			
			//send data to RegisterServlet	
  			$.ajax({
  				url:"RegisterServlet",
  				data:form,
  				type:'POST',
  				success: function(data,textStatus,jqXHR){
  					console.log(data);
  					console.log("success....");
  
  					$("#msg").show();
  					if(data.trim()=='done')
  					{
  						$('#msg').html("Successfully registered!!!!!");
  						console.log("data entered");
  						setTimeout(function(){
  							window.location="login.jsp";
  						},2000);
  						
  						
  					}
  					else
  						{
  						$('#msg').html("Something went wrong");						
  						console.log("data not entered else part");
  						setTimeout(function(){
  							window.location="register_page.jsp";
  						},2000);
  						}
  					  					
  				},
  				error: function(jqXHR,textStatus,errorThrown){
  					console.log("error....");
  					
  					$("#msg").show();
  					$('#msg').html("Something went wrong");
  					setTimeout(function(){
							window.location="register_page.jsp";
						},2000);
  					console.log("data not entered error part");
  				},
  				processData:false,
  				contentType:false
  				
  			});
  			
  		})
  	})
  </script>


</body>
</html>