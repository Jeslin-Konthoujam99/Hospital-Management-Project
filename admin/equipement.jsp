<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Equipement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  </head>
   <style>
  .nav-link 
  
  {
  	color:white;
  }
  	
  .navbar-brand
  {
  	color:white;
  	  }
  	  
  body{
  	background:url(Photos/body.jpg);
  	background-size: cover;
  	background-position: center;
  	background-attahchment:fixed
  	  }
  
  a{
  	text-decoration: none;
  }
  
	  </style>
  <body>
    <br><br>
    
    <div class="m-5 shadow-lg bg-light rounded">
	<div class="container_fluid">
	<div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Add Equipment</div>
   <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/equipement" method="post" class="bg-light p-4 rounded">
                    <div class="mb-3">
                        <label for="equipmentname" class="form-label">Equipment Name:</label>
                        <input type="text" name="equipmentname" class="form-control" placeholder="Equipment Name" required>
                    </div>
                    <div class="mb-3">
                        <label for="departmentid" class="form-label">Department ID:</label>
                        <input type="text" name="departmentid" class="form-control" placeholder="Department ID" required>
                    </div>
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Quantity:</label>
                        <input type="number" name="quantity" class="form-control" placeholder="Quantity" required>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Price:</label>
                        <input type="number" name="price" class="form-control" placeholder="Price" required>
                    </div>
                    <div class="mb-3">
                        <label for="lowStockqty" class="form-label">Low Stock Quantity:</label>
                        <input type="number" name="lowStockqty" class="form-control" placeholder="Low Stock Quantity" required>
                    </div>
                    <div class="mb-3">
                        <label for="datetime" class="form-label">Date:</label>
                        <input type="datetime-local" name="datetime" class="form-control" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Add</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    </div>
	</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
  </body>
</html>