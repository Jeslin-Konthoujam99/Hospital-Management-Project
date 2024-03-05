package adminPk;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

@WebServlet("/UpdateNurse")
public class UpdateNurse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{String Empid = request.getParameter("Empid");
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

    SQLConnect model = new SQLConnect();
    Connection con = model.connect();
    PreparedStatement ps = null;

    try {
        ps = con.prepareStatement("UPDATE employeelist SET empid=?, firstname=?, lastname=?, gender=?, age=?, department_id=?, designation=?, email=?, phone=?, address=?, district=?, state=?, country=?, pin=?, username=?, password=? WHERE aadhaar=?");

        ps.setString(1, Empid);
        ps.setString(2, FirstName);
        ps.setString(3, LastName);
        ps.setString(4, Gender);
        ps.setString(5, Age);
        ps.setInt(6, Department);
        ps.setString(7, Designation);
        ps.setString(8, Email);
        ps.setString(9, PhoneNumber);
        ps.setString(10, Address);
        ps.setString(11, District);
        ps.setString(12, State);
        ps.setString(13, Country);
        ps.setString(14, Pin);
        ps.setString(15, Username);
        ps.setString(16, Password);
        ps.setString(17, AadhaarNumber);

        ps.executeUpdate();
        response.sendRedirect("admin/ViewNurse.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("admin/Failed.jsp");
    } finally {
        try {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
}