package adminPk;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

/**
 * Servlet implementation class InsertIpdBill
 */
@WebServlet("/InsertIpdBill")
public class InsertIpdBill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertIpdBill() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ipdAppointmentId = Integer.parseInt(request.getParameter("ipd_appointment_id"));
        int amount = Integer.parseInt(request.getParameter("amount"));
        String reason = request.getParameter("reason");
        String date = request.getParameter("date");
        
        SQLConnect obj=new SQLConnect();
		Connection connection=obj.connect();
		PreparedStatement preparedStatement=null;

        
        String sql = "INSERT INTO ipd_bill (ipd_appointment_id, amount, reason, date) VALUES (?, ?, ?, ?)";
        try {
        	preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, ipdAppointmentId);
            preparedStatement.setInt(2, amount);
            preparedStatement.setString(3, reason);
            preparedStatement.setString(4, date);

            preparedStatement.executeUpdate();
        }
        catch (SQLException e) {
        e.printStackTrace(); // Handle or log the exception as needed
        }

        response.sendRedirect("admin/insert_ipdBill.jsp"); // Redirect to a success page
    }
}
