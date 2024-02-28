package patientIPD;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import login.SQLConnect;


/**
 * Servlet implementation class PayIpdBill
 */
@WebServlet("/PayIpdBill")
public class PayIpdBill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PayIpdBill() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		int ipd_appointment_id = 0 ;
		int amount=0;
		//retrieve booked_id
		if(     	request.getParameter("ipd_appointment_id") != null 
				&& !request.getParameter("ipd_appointment_id").isEmpty() 
				&& request.getParameter("amount") != null 
				&& !request.getParameter("amount").isEmpty()
		){
		ipd_appointment_id = Integer.parseInt(request.getParameter("ipd_appointment_id"));

		// Retrieve the discountedAmount from the request
		amount = Integer.parseInt(request.getParameter("amount"));
		}
		else 
		{
			System.out.println("empty or null form sent . ");
			 RequestDispatcher dispatcher = 
                     request.getRequestDispatcher("index.jsp");
             dispatcher.forward(request, response);
			
		}
        request.setAttribute("ipd_appointment_id", ipd_appointment_id);
        request.setAttribute("amount", amount);

        // Perform payment processing and acknowledgement here...
        

     
        
        SQLConnect model = new SQLConnect();
        Connection connection = null;
        try {
            connection = model.connect();
        }catch(Exception e) {
        	e.printStackTrace();
        }
        
        String status = "paid"; 
       
        // insert into ipd_bill
        String sql = 
        		"INSERT INTO ipd_bill (ipd_appointment_id, amount, reason, date)"+
        			" VALUES (?, ?, ?, NOW() )";
       
        	 try (PreparedStatement preparedStatement =
        			 connection.prepareStatement(sql)) {
                 preparedStatement.setInt(1, ipd_appointment_id);
                 preparedStatement.setInt(2, amount);
                 preparedStatement.setString(3, status);
                

                 // Execute the query
                 int rowsAffected = preparedStatement.executeUpdate();

                 if (rowsAffected > 0) {
                     System.out.println("Data inserted successfully!");
                 } 
                 else 
                 {
                     System.out.println("Failed to insert data.");
                 }//if else
             }//try
        	 catch (SQLException e) {
        		 e.printStackTrace();
        	 }//catch 
        	 
     		HttpSession session = request.getSession();

 // Create a PreparedStatement
        	 String sql1 = "SELECT \r\n"
        				+ "    i.ipd_appointment_id,\r\n"
        				+ "    i.checkin_date,\r\n"
        				+ "    i.status,\r\n"
        				+ "    i.residency,\r\n"
        				+ "    e.firstname AS doctor_firstname,\r\n"
        				+ "    e.lastname AS doctor_lastname,\r\n"
        				+ "    n.firstname AS nurse_firstname,\r\n"
        				+ "    n.lastname AS nurse_lastname,\r\n"
        				+ "    w.ward_name\r\n"
        				+ "FROM \r\n"
        				+ "    ipd_appointment i\r\n"
        				+ "JOIN \r\n"
        				+ "    employeelist e ON i.doctor_id = e.employee_id\r\n"
        				+ "JOIN \r\n"
        				+ "    employeelist n ON i.nurse_id = n.employee_id\r\n"
        				+ "JOIN \r\n"
        				+ "    ward w ON i.ward_id = w.ward_id where i.ipd_appointment_id=? ";
 try (PreparedStatement preparedStatement = connection.prepareStatement(sql1)) {
     preparedStatement.setInt(1, ipd_appointment_id);

     // Execute the query
     ResultSet resultSet = preparedStatement.executeQuery();

     if (resultSet.next()) {

         String checkin_date = resultSet.getString("i.checkin_date");
         String wardName = resultSet.getString("w.ward_name");
         String doctorFirstName = resultSet.getString("doctor_firstname") + " " 
        		 + resultSet.getString("doctor_lastname");
         String nurseFirstName = resultSet.getString("nurse_firstname") + " " 
                 + resultSet.getString("nurse_lastname");
         
         String patientFullName = (String) session.getAttribute("fullname");

         request.setAttribute("patientFullName", patientFullName);
         request.setAttribute("checkin_date", checkin_date);
         request.setAttribute("wardName", wardName);
         request.setAttribute("doctorFirstName", doctorFirstName);
         request.setAttribute("nurseFirstName", nurseFirstName);


         System.out.println("Patient Full Name: " + patientFullName);
         System.out.println("checkin_date: " + checkin_date);
         System.out.println("Ward Name: " + wardName);
         System.out.println("Doctor First Name: " + doctorFirstName);
         System.out.println("Nurse First Name: " + nurseFirstName);
     } else {
         System.out.println("No appointment found for the given ID.");
     }// if else
 
 } catch (SQLException e) {
     e.printStackTrace();
 }// try catch
        	 
        	// Forward to opd_receipt.jsp
             RequestDispatcher dispatcher = 
                     request.getRequestDispatcher("patient/receipt_ipd.jsp");
             dispatcher.forward(request, response);

		
		
	}//doPost

}//PayIpdBill
