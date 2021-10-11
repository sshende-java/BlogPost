<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page isErrorPage="true" %>

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
<title>Sorry!! Something went wrong</title>

</head>
<body>

<div class="container text-center">
	<img style="margin-top:10px;" src="images/warning.png" alt="error" class="img-fluid" height="100" width="100"/>
	<h3 class="display-4">Sorry ! Something went wrong.....</h3>
	<%=exception %><br>
	<a  href="index.jsp" class="btn primary-background text-white mt-3">Home</a>
</div>

</body>
</html>