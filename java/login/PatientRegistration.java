package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PatientRegistration
 */
@WebServlet("/PatientRegistration")
public class PatientRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PatientRegistration() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		SQLConnect obj = new SQLConnect();
		Connection con = obj.connect();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String careof ="c";
		if(request.getParameter("care")!=null)
		{
			careof=request.getParameter("care");
		}
		
		String email ="e";
		if(request.getParameter("email")!=null)
		{
			email=request.getParameter("email").trim();
		}
		long contact = 0;
		try
		{
			contact=Long.parseLong(request.getParameter("contact"));
		}
		catch (NumberFormatException e) {
            // Handle the NumberFormatException (e.g., log it, display an error message, etc.)
            System.err.println("Invalid phone number format. Please enter a valid number.");
        } catch (IllegalArgumentException e) {
            // Handle the case where the phone number is null or empty
            System.err.println(e.getMessage());
        }
		String address="a";
		if(request.getParameter("address")!=null)
		{
			address=request.getParameter("address");
		}
		String password = request.getParameter("password");
		String conpassword = request.getParameter("conPassword");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		if (!password.equals(conpassword)) 
		{
			System.out.println("register not executed");
			out.println("<p class='fs-1 fst-italic bg-danger text-center'>  Passwords dont match  .</p>");
			RequestDispatcher rd = request.getRequestDispatcher("login/patientRegister.jsp");
			rd.include(request, response);	
		}
		else
		{
			

			try 
			{
				ps = con.prepareStatement("select * from patients where email=?");
				ps.setString(1, email);
				rs=ps.executeQuery();
				if(rs.next())
				{
					System.out.println("register not executed");
					out.println("<p class='fs-1 fst-italic bg-danger text-center'>  email already exists .</p>");
					RequestDispatcher rd = request.getRequestDispatcher("login/patientRegister.jsp");
					rd.include(request, response);	
				}
				else
				{
					try {
						ps = con.prepareStatement(
								"insert into patients(fullname,age,gender,care_of,"
								+ "email,phone,address,password) values(?,?,?,?,?,?,?,?)");
						ps.setString(1, request.getParameter("name"));
						ps.setInt(2, Integer.parseInt(request.getParameter("age")));
						ps.setString(3, request.getParameter("gender"));
						ps.setString(4, careof);
						ps.setString(5, email);
						ps.setDouble(6, contact);
						ps.setString(7, address);
	
						
							ps.setString(8, password);
							ps.executeUpdate();
							System.out.println("register executed");
							
							out.println("<p class='fs-1 fst-italic bg-success text-center'> registered successfully .</p>");
							RequestDispatcher rd = request.getRequestDispatcher("login/patientLogin.jsp");
							rd.include(request, response);			
							
					} catch (Exception e) {
						e.printStackTrace();
						System.out.println(e);
						System.out.println("Data not inserted...");
						out.println("<p class='fs-1 fst-italic bg-danger text-center'>  some db error  .</p>");
						RequestDispatcher rd = request.getRequestDispatcher("login/patientRegister.jsp");
						rd.include(request, response);			
						}
				}
				
				
			}
			catch (Exception e) 
			{
					e.printStackTrace();
					System.out.println(e);
					System.out.println("Data not inserted...");
					out.println("<p class='fs-1 fst-italic bg-danger text-center'> some error.</p>");
					RequestDispatcher rd = request.getRequestDispatcher("login/patientRegister.jsp");
					rd.include(request, response);			
			}
		
		}//else


	}//dopost

}//class end
