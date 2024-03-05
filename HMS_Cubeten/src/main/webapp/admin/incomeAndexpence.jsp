

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="adminPk.Bills" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Overall Income and Expenditure</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="admin/generatePdf.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
    body{
    padding:100px;
    }
    
    </style>
</head>
<body>

<% 
    System.out.println("jsp loaded");
    List<Bills> bills = (List<Bills>) session.getAttribute("bills");
    String sortBy = (String) session.getAttribute("sortBy");
	   
    if (sortBy == null || sortBy.trim().isEmpty()) {
        sortBy = "defaultColumn";
    }
    System.out.println("sortBy: " + sortBy);
    
%>

<%
    List<String> billTypesForChart = (List<String>) session.getAttribute("billTypesForChart");
    List<Double> amountsForChart = (List<Double>) session.getAttribute("amountsForChart");

    
    StringBuilder billTypesArray = new StringBuilder("[");
    StringBuilder amountsArray = new StringBuilder("[");
    
    if (billTypesForChart != null) {
        for (int i = 0; i < billTypesForChart.size(); i++) {
            billTypesArray.append("'" + billTypesForChart.get(i) + "'");
            amountsArray.append(amountsForChart.get(i));

           
            if (i < billTypesForChart.size() - 1) {
                billTypesArray.append(", ");
                amountsArray.append(", ");
            }
        }
    }

    billTypesArray.append("]");
    amountsArray.append("]");
%>


<div class="container mt-3">
    <form method="get" action="${pageContext.request.contextPath}/InExServlet" class="mb-3">
        <button type="submit" name="sortBy" value="defaultColumn" class="btn btn-secondary" <%= "defaultColumn".equals(request.getParameter("sortBy")) ? "disabled" : "" %>>Default Sort</button>
        <button type="submit" name="sortBy" value="bill_type" class="btn btn-secondary" <%= "bill_type".equals(request.getParameter("sortBy")) ? "disabled" : "" %>>Sort by Bill Type</button>
        <button type="submit" name="sortBy" value="amount" class="btn btn-secondary" <%= "amount".equals(request.getParameter("sortBy")) ? "disabled" : "" %>>Sort by Amount</button>
        <button type="submit" name="sortBy" value="date" class="btn btn-secondary" <%= "date".equals(request.getParameter("sortBy")) ? "disabled" : "" %>>Sort by Date</button>
    </form>
</div>

<div class="container mt-5" id="genPDF">
    <h1 class="display-4">Overall Income and Expenditure</h1>

    <% if (bills != null) { %>
        <table class="table table-hover mt-5">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Bill Type</th>
                    <th scope="col">Amount</th>
                    <th scope="col">Date Created</th>
                    <th scope="col">Income or Expenditure</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Bills bill : bills) {
                %>
                        <tr>
                            <td><%= bill.getBillType() %></td>
                            <td><%= bill.getAmount() %></td>
                            <td><%= bill.getCreatedAt() %></td>
                            <td><%= bill.getIsIncome() == 1 ? "Income" : "Expenditure" %></td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p class="lead">No bills available.</p>
    <%
        }
    %>

    <div class="summary mt-4">
        <h2 class="display-5">Financial Summary</h2>
        <div class="mb-3 mt-3">
            <p class="fw-bold" style="font-size:20px">
                Total Income Amount: <%=  session.getAttribute("incomeAmount") %>
            </p>
            <p class="fw-bold" style="font-size:20px">
                Total Expenditure Amount: <%= session.getAttribute("expenditureAmount") %>
            </p>
        </div>
    </div>
</div>



<div class="container-md p-5">
    <div class="row p-4">
        <div class="col-md-6 pe-5 ps-5">
            <canvas id="myChart" style="width: 100%; height: auto;"></canvas>
        </div>
        <div class="col-md-6 pe-5 ps-5">
            <canvas id="myChart1" style="width: 100%; height: auto;"></canvas>
        </div>
    </div>
</div>

	
	
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>   		
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>

    <script>
    
    var incomeAmount = <%= session.getAttribute("incomeAmount") %>;
    var expenditureAmount = <%= session.getAttribute("expenditureAmount") %>;

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Income', 'Expenditure'],
            datasets: [{
                label: 'Income/Expenditure',
                data: [incomeAmount, expenditureAmount],
                backgroundColor: [
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(255, 99, 132, 0.2)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)',
                    'rgba(255, 99, 132, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
        	responsive: true,
            
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    
    var billTypesForChart = <%= billTypesArray %>;
    var amountsForChart = <%= amountsArray %>;

    var ctx1 = document.getElementById('myChart1').getContext('2d');
    var myChart1 = new Chart(ctx1, {
        type: 'bar',
        data: {
            labels: billTypesForChart,
            datasets: [{
                label: 'Amount per Bill Type',
                data: amountsForChart,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
        	responsive: true,
            
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    
</script>

<script>
    window.onload = function() {
       
        var defaultColumn = 'defaultColumn';

        var sortingParamPresent = window.location.href.indexOf('sortBy=') !== -1;

        if (!sortingParamPresent && window.performance.navigation.type === 1) {
      
            var redirectUrl = 'InExServlet?sortBy=' + defaultColumn;

            window.location.href = redirectUrl;
        }
    };
</script>

</body>
</html>
