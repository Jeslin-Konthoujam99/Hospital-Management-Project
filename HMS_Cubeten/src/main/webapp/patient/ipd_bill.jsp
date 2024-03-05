<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Ipd Bill Cards</title>
    <!-- Bootstrap CSS link -->
   <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
        body {
            padding: 100px;
        }

        .card {
            font-size: 18px;
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card h3 {
            margin-bottom: 5px;
        }

        .card p {
            margin: 0;
        }

        .total-card {
            font-size: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">Ipd Bill Cards</h1>

        <c:forEach var="ipdBill" items="${requestScope.ipdBillList}">
            <div class="card">
                <p>Amount: ${ipdBill.amount}</p>
                <p>Status: ${ipdBill.reason}</p>
                <p>Date: ${ipdBill.date}</p>
            </div>
        </c:forEach>

        <hr>

        <div class="card total-card">
            Total bill: ${requestScope.totbill} <br>
            Total paid: ${requestScope.totpaid} <br>
            Total amount left to pay: ${requestScope.totamt} <br>

            <form action="patient/pay_ipd.jsp" method="post">
                <input type="hidden" id="ipd_appointment_id" value="${requestScope.ipd_appointment_id}" name="ipd_appointment_id" class="form-control mb-2">

                <label for="amount">Pay amount:</label>
                <input type="number" id="amount" name="amount" class="form-control mb-2">

                <input type="submit" value="Pay Bills" class="btn btn-primary">
            </form>

            
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js scripts (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-Mrlg7GQUn1Fx9vHvMUblFqIfb8fQGqe3fEzRWi5Na6ZlgpVFFbXBYvccERyXxmqq" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyklCyaqBDa" crossorigin="anonymous"></script>
</body>
</html>
