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
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class DeleteMedicine
 */
@WebServlet("/DeleteMedicine")
public class DeleteMedicine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteMedicine() {
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
        SQLConnect conn = new SQLConnect();
        Connection connection = conn.connect();

        try 
        {
            
            // Delete data from the "medicines" table
            String deleteQuery = "DELETE FROM medicines WHERE medicine_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
                // Set value for the prepared statement
            preparedStatement.setInt(1, Integer.parseInt(request.getParameter("medicine_id")));

            // Execute the deletion
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) 
            {
            	System.out.println("<br><br><br>.........Medicine deleted successfully!");
                out.println("<br><br><br>.........Medicine deleted successfully!");
            	RequestDispatcher rd = request.getRequestDispatcher("pharma/view_medicine.jsp");
        		rd.include(request, response);
            } else 
            {
            	System.out.println("<br><br><br>.........Failed to delete medicine. Please try again.");
                out.println("<br><br><br>.........Failed to delete medicine. Please try again.");
            	RequestDispatcher rd = request.getRequestDispatcher("pharma/view_medicine.jsp");
        		rd.include(request, response);
            }
            
        

        } catch (Exception e) {
        	System.out.println("<br><br><br>.........Failed to delete medicine. some exception.");
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("pharma/view_medicine.jsp");
    		rd.include(request, response);
        }
    }
}