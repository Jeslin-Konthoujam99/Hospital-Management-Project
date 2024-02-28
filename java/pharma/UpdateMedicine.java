package pharma;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class UpdateMedicine
 */
@WebServlet("/UpdateMedicine")
public class UpdateMedicine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMedicine() {
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
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // JDBC parameters
        SQLConnect con = new SQLConnect();
        Connection connection = con.connect();

        try 
        {
            
            // Update data in the "medicines" table
            String updateQuery = "UPDATE medicines SET medicine_name=?, manufacturer=?, dosage_form=?, active_ingredient=?, unit_price=? WHERE medicine_id=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {
                // Set values for the prepared statement
                preparedStatement.setString(1, request.getParameter("medicine_name"));
                preparedStatement.setString(2, request.getParameter("manufacturer"));
                preparedStatement.setString(3, request.getParameter("dosage_form"));
                preparedStatement.setString(4, request.getParameter("active_ingredient"));
                preparedStatement.setBigDecimal(5, new BigDecimal(request.getParameter("unit_price")));
                preparedStatement.setInt(6, Integer.parseInt(request.getParameter("medicine_id")));

                // Execute the update
                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                	System.out.println("<br><br><br>...........Medicine updated successfully!");
                    out.println("<br><br><br>...........Medicine updated successfully!");
            		RequestDispatcher rd = request.getRequestDispatcher("pharma/view_medicine.jsp");
            		rd.include(request, response);
                } else {
                	System.out.println("<br><br><br>...........Failed to update medicine. Please try again.");
                    out.println("<br><br><br>...........Failed to update medicine. Please try again.");
            		RequestDispatcher rd = request.getRequestDispatcher("pharma/view_medicine.jsp");
            		rd.include(request, response);
                }
            }
        

        } catch (Exception e) {
        	System.out.println("Excetion Error: ");

            e.printStackTrace();
            out.println("Excetion Error: " + e.getMessage());
            out.println("<br><br><br>...........Failed to update medicine. Please try again.");
    		RequestDispatcher rd = request.getRequestDispatcher("pharma/view_medicine.jsp");
    		rd.include(request, response);
        }
    }
}
