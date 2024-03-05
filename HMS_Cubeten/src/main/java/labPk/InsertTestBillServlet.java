package labPk;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

@WebServlet("/InsertTestBillServlet")
public class InsertTestBillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String prescriptionIdStr = request.getParameter("prescriptionId");
		String amountStr = "5000";
		String paymentStatus = "paid";

		// Convert prescriptionId to int
		int prescriptionId = Integer.parseInt(prescriptionIdStr);

		// Convert amount to BigDecimal
		BigDecimal amount = new BigDecimal(amountStr);

		// Convert date to java.sql.Date
		Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
		// Database operation
		SQLConnect model = new SQLConnect();
		Connection connection = model.connect();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		try 
		{
			String sql = "INSERT INTO testbill (prescription_id, amount, date, payment_status) VALUES (?, ?, ?, ?)";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, prescriptionId);
			statement.setBigDecimal(2, amount);
			statement.setTimestamp(3, currentTimestamp);

			statement.setString(4, paymentStatus);
			statement.executeUpdate();
			System.out.println("test bill inserted");

			

		} catch (Exception e) 
		{
			System.out.println("exception in insert opd bill servlet  ");
			e.printStackTrace();
			out.println("<br><br><br><p class='fs-1 bg-danger text-center'>Failed to insert in opd test bill .</p>");
			RequestDispatcher rd = request.getRequestDispatcher("lab/insert_opd_test_bill.jsp");
			rd.include(request, response);

		}
		try 
		{
			String sql = "UPDATE opd_prescriptions\r\n"
					+ "SET test = 'blood paid'\r\n"
					+ "WHERE prescription_id = ?\r\n";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, prescriptionId);
			statement.executeUpdate();
			System.out.println("updated test of prescription to blood paid ");

			

		} catch (Exception e) 
		{
			// Handle database errors
			e.printStackTrace();
			out.println("<br><br><br><p class='fs-1 bg-danger text-center'>Failed to update test in opd prescription  .</p>");
			RequestDispatcher rd = request.getRequestDispatcher("lab/insert_opd_test_bill.jsp");
			rd.include(request, response);

		}
		
		
		
		
		out.println("<br><br><br><p class='fs-1 fc-success text-center'>Test bill generated.</p>");
		RequestDispatcher rd = request.getRequestDispatcher("lab/insert_opd_test_bill.jsp");
		rd.include(request, response);

	}

}
