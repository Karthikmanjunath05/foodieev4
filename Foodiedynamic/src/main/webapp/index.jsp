<%@page import="com.FoodieServers.productobj"%>
<%@page import="com.FoodieServers.productdao"%>
<%@page import="com.FoodieServers.DbCon"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.FoodieModels.Cart"%>
<%@page import="com.FoodieModels.User"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("person", auth);
    }else{ 
    	response.sendRedirect("Login.jsp");}
productdao pd = new productdao(DbCon.getConnection());
String top8 ="Select * from `food_items` limit 8;";
List<productobj> products = pd.getAllProducts(top8);
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
	}
%>

<html>
<head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<script src="https://kit.fontawesome.com/64e1bb2e91.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<nav class="navbar fixed-top navbar-expand-md navbar-light bg-light" id= "myHeader">
  <a href="index.jsp" class="navbar-brand"><i><strong>Foodie</strong></i></a>

  <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#mnav">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse nav-container" id="mnav">
    <ul class="navbar-nav navmargin">
      <li class="nav-item"><a href="index.jsp" class="nav-link">Home</a></li>
          <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Categories
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="chinees.jsp">Chinees</a></li>
            <li><a class="dropdown-item" href="northindian.jsp">North Indian</a></li>
            <li><a class="dropdown-item" href="southindian.jsp">South Indian</a></li>
            <li><a class="dropdown-item" href="western.jsp">Western</a></li>
          </ul>
        </li>
          <li class="nav-item"><a href="orders.jsp" class="nav-link">Previous Orders</a></li>
        </ul>
      <form class="form-inline d-flex flex-nowrap searchbar">
        <input type="search" class="form-control" placeholder="search">
        <button class="btn btn-outline-danger">Search</button>
      </form>
      <a class="nav-link cartlink" href="Cart.jsp" style="margin-left: 1%;">Cart </a>
      <div style="font-size: 10px" class="badge bg-danger cart-img-badge"><span>${ cart_list.size() }</span></div>
      <a href="Profilepage.jsp"  data-toggle="modal" data-target="#exampleModal"class="nav-link profile-name" style="margin-left: 1%;"><i class="fa-solid fa-user">  </i><%= auth.getName() %></a>
  </div>
	<a href="logout"><button class="btn btn-outline-danger logout">Logout</button></a>
</nav>
	
	<div class="container" style="margin-top: 30px">
		<div class="row" style="width: 100%; height: 100%">
			<div class="col-md-6 my-6 "
				style="display: flex; flex-direction: column; justify-content: center">
				<p class="h1">Hungry?!</p>
				<br>
				<p class="h3">Good. We are here to serve you .</p>
				<br>
				<button type="button" class="btn btn-lg btn-danger" ><a style="color:white;" href="AllFoodItems.jsp">Start
					ordering now</a></button>
			</div>
			<div class="col-md-6 my-6">
				<img class="card-img-top" style="border-radius: 25px"
					src="product-image/vegfood.jpeg" alt="Card image cap">
			</div>
		</div>
		<div class="top">
			<h4>Food Items</h4>
			<div class="view-all">
				<a href="AllFoodItems.jsp">View All</a>
			</div>
		</div>
		<div class="row">
			<%
			if (!products.isEmpty()) {
				for (productobj p : products) {
			%>
			<div class="col-md-3 my-3">
				<div class="card w-100" style="width: 25rem;">
					<img class="card-img-top" style="height: 20rem;" src="<%=p.getImage()%>"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">
							Price: $
							<%=p.getPrice()%></h6>
						<h6 class="category">
							Category:
							<%=p.getCategory()%></h6>
						<div class="mt-3 d-flex justify-content-between ">
							<a href="AddToCart?id=<%=p.getId()%>"
								class="btn btn-danger btn-sm">Add to Cart</a> <a href="order-now?quantity=1&id=<%=p.getId()%>"
								class="btn btn-danger btn-sm">Order Now </a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>

		<%@include file="footer.jsp"%>
</body>
</html>
