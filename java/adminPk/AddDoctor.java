package adminPk;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

@WebServlet("/AddDoctor")
public class AddDoctor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String EmpId = request.getParameter("EmpId");
		String FirstName = request.getParameter("FirstName");
		String LastName = request.getParameter("LastName");
		String Gender = request.getParameter("Gender");
		String Age = request.getParameter("Age");
		int Department =Integer.parseInt(request.getParameter("Department"));
		String Designation = request.getParameter("Designation");
		String AadhaarNumber = request.getParameter("AadhaarNumber");
		String Email = request.getParameter("Email");
		String PhoneNumber = request.getParameter("PhoneNumber");
		String Address = request.getParameter("Address");
		String District = request.getParameter("District");
		String State = request.getParameter("State");
		String Country = request.getParameter("Country");
		String Pin = request.getParameter("Pin");
		String Username = request.getParameter("Username");
		String Password = request.getParameter("Password");
		String ConfirmPassword = request.getParameter("ConfirmPassword");
		String role = "doctor" ;
		
		
		
		SQLConnect con=new SQLConnect();
		Connection con1=con.connect();
		PreparedStatement ps=null;
		ResultSet generatedKeys=null;
		try
		{
			if(Password.equals(ConfirmPassword))
			{
				ps = con1.prepareStatement("INSERT INTO employeelist (empid, firstname, lastname, gender, age, department_id, designation, aadhaar, email, phone, address, district, state, country, pin, username, password, role, joined_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURDATE() )",Statement.RETURN_GENERATED_KEYS);

				ps.setString(1, EmpId);
				ps.setString(2, FirstName);
				ps.setString(3, LastName);
				ps.setString(4, Gender);
				ps.setString(5, Age);
				ps.setInt(6, Department);
				ps.setString(7, Designation);
				ps.setString(8, AadhaarNumber);
				ps.setString(9, Email);
				ps.setString(10, PhoneNumber);
				ps.setString(11, Address);
				ps.setString(12, District);
				ps.setString(13, State);
				ps.setString(14, Country);
				ps.setString(15, Pin);
				ps.setString(16, Username);
				ps.setString(17, Password);
				ps.setString(18, role);
				

				ps.executeUpdate();
				System.out.println("doctor added");
				generatedKeys = ps.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                int generatedPK = generatedKeys.getInt(1); // Assuming the primary key is an integer
	                System.out.println("Generated PK: " + generatedPK);
	                // You can now use the generated PK as needed
	                try 
	                {
	                	ps = con1.prepareStatement("INSERT INTO doctor_rates (doctor_id, rate) VALUES (?, 1000 )");
	    				ps.setInt(1, generatedPK);
	    				ps.executeUpdate();
	    				System.out.println("doctor rate added");

	                	
	                }catch(Exception e)
	        		{
		                System.out.println("Some error . Generated PK: " + generatedPK);
	        			e.printStackTrace();
	        		}
	                
	                
	                
	                
	            } else {
	                System.out.println("No auto-generated keys were returned. doctor rates not added");
	            }

				response.sendRedirect("admin/ViewDoctor.jsp");

			}else
			{
				response.sendRedirect("admin/AddDoctor.jsp?error=passwordMismatch");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			response.sendRedirect("admin/Failed.jsp");
		}
	}

}