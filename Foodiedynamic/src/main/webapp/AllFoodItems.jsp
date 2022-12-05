<%@page import="com.FoodieServers.productobj" %>
<%@page import="com.FoodieServers.productdao" %>
<%@page import="com.FoodieServers.DbCon" %>
<%@page import="com.FoodieModels.Cart" %>
<%@page import="com.FoodieModels.User" %>
<%@page import="java.util.List" %>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
	}

%>

<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<script src="https://kit.fontawesome.com/64e1bb2e91.js" crossorigin="anonymous"></script>
</head>
<body style="margin-top:70px;">

 <%@include file="header.jsp" %>
		<div class="top">
	            <h4>All Food Items</h4>
	            <div class="view-all" >View All</div>
	        </div>
		<div class="row">
		<%
		productdao pd = new productdao(DbCon.getConnection());
		String allItems = "Select * from `food_items`";
		List<productobj> products = pd.getAllProducts(allItems);
		if(!products.isEmpty()){
			for(productobj p:products){%>
				<div class="col-md-3 my-3">
				<div class="card w-100" style="width:25rem;">
					<img class="card-img-top" style="height: 20rem;" src="<%= p.getImage() %>" alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%= p.getName() %></h5>
						<h6 class="price">Price: $ <%= p.getPrice()  %></h6>
						<h6 class="category">Category: <%= p.getCategory() %></h6>
						<div class="mt-3 d-flex justify-content-between ">
							<a href="AddToCart?id=<%=p.getId()%>" class="btn btn-danger btn-sm">Add to Cart</a>
							<a href="order-now?quantity=1&id=<%=p.getId()%>" class="btn btn-danger btn-sm">Order Now </a>
						</div>
					</div>
				</div>
			</div>
			<%}
		}
		%>			
	</div>

 <%@include file="footer.jsp" %>
</body>
</html>
