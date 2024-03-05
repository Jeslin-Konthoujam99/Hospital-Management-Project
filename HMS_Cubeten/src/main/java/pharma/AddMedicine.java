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
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Servlet implementation class AddMedicine
 */
@WebServlet("/AddMedicine")
public class AddMedicine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMedicine() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try 
        {
        	SQLConnect con=new SQLConnect();
    		Connection connection=con.connect();

            // Retrieve data from the form
            String medicineName = request.getParameter("medicine_name");

            // Check if medicine name already exists
            if (isMedicineNameExists(connection, medicineName)) 
            {
                out.println("Medicine with the given name already exists. Please choose a different name.");
            } 
            else 
            {
                // Insert data into the "medicines" table
                String insertQuery = "INSERT INTO medicines (medicine_name, manufacturer, dosage_form, active_ingredient, unit_price) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
                // Set values for the prepared statement
                preparedStatement.setString(1, request.getParameter("medicine_name"));
                preparedStatement.setString(2, request.getParameter("manufacturer"));
                preparedStatement.setString(3, request.getParameter("dosage_form"));
                preparedStatement.setString(4, request.getParameter("active_ingredient"));
                preparedStatement.setBigDecimal(5, new BigDecimal(request.getParameter("unit_price")));

                // Execute the update
                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                	System.out.println("Medicine added successfully!");
                	out.println("<br><br><br><p class='fs-1 fst-italic bg-danger text-center'> ............Medicine added successfully! .</p>");
                    RequestDispatcher rd = request.getRequestDispatcher("pharma/add_medicine.jsp");
    				rd.include(request, response);
                } else {
                	System.out.println("Failed to add medicine. Please try again.");
                	out.println("<br><br><br><p class='fs-1 fst-italic bg-danger text-center'> ............Failed to add medicine. Please try again. .</p>");
                    out.println("Failed to add medicine. Please try again.");
                    RequestDispatcher rd = request.getRequestDispatcher("pharma/add_medicine.jsp");
    				rd.include(request, response);
                }
            }
        }           
        catch (Exception e) 
        {
        	System.out.println("Excetion ....");
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("pharma/add_medicine.jsp");
			rd.include(request, response);
        }
    }

    private boolean isMedicineNameExists(Connection connection, String medicineName) throws SQLException 
    {
        String checkQuery = "SELECT medicine_id FROM medicines WHERE medicine_name = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(checkQuery)) 
        {
            preparedStatement.setString(1, medicineName);

            try (ResultSet resultSet = preparedStatement.executeQuery()) 
            {
                return resultSet.next(); // Returns true if the medicine name already exists
            }
        }
    }
}
