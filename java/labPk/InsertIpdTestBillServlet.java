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

@WebServlet("/InsertIpdTestBillServlet")
public class InsertIpdTestBillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String prescriptionIdStr = request.getParameter("ipdPrescriptionId");
		String amountStr = "5000";
		String paymentStatus = "paid";
		
		// Database operation
		SQLConnect model = new SQLConnect();
		Connection connection = model.connect();
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		try {
			// Convert prescriptionId to int
			int prescriptionId = Integer.parseInt(prescriptionIdStr);

			// Convert amount to BigDecimal
			BigDecimal amount = new BigDecimal(amountStr);

			// Convert date to java.sql.Date
			Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

			String sql = "INSERT INTO ipd_test_bill (ipd_prescription_id, test_cost, test_date, payment_status) VALUES (?, ?, ?, ?)";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, prescriptionId);
			statement.setBigDecimal(2, amount);
			statement.setTimestamp(3, currentTimestamp);
			statement.setString(4, paymentStatus);
			statement.executeUpdate();
			
			System.out.println("inserted ipd bill ");
			
			try 
			{
				String sql1 = "UPDATE ipd_prescription\r\n"
						+ "SET test_required = 'blood paid' \r\n"
						+ "WHERE prescription_id = ?\r\n";
				
				statement = connection.prepareStatement(sql1);
				statement.setInt(1, prescriptionId);
				statement.executeUpdate();
				System.out.println("updated test of ipd prescription to blood paid ");

				

			} catch (Exception e) 
			{
				// Handle database errors
				e.printStackTrace();
				out.println("<br><br><br><p class='fs-1 bg-danger text-center'>Failed to update test in ipd prescription  .</p>");
				RequestDispatcher rd = request.getRequestDispatcher("lab/insert_ipd_test_bill.jsp");
				rd.include(request, response);

			}

			out.println("<br><br><br><p class='fs-1 bg-success text-center'>Test bill generated.</p>");
			RequestDispatcher rd = request.getRequestDispatcher("lab/insert_ipd_test_bill.jsp");
			rd.include(request, response);		
			
		}catch (Exception e) 
		{
			System.out.println("exception in insert ipd bill servlet  ");
			e.printStackTrace();

			out.println("<br><br><br><p class='fs-1 bg-danger text-center'>Failed to generate Test bill.</p>");
			RequestDispatcher rd = request.getRequestDispatcher("lab/insert_ipd_test_bill.jsp");
			rd.include(request, response);
		} 
		finally 
		{
			try {
				if (connection != null) {
					connection.close();
					System.out.println("closed connection .   ");

					
				}
			} catch (Exception e) {
				// Handle connection close error
				System.out.println("Error closing database connection....."+ e);
			}
		}

	}

}
