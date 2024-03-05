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
 * Servlet implementation class UpdateDoctorRate
 */
@WebServlet("/UpdateDoctorRate")
public class UpdateDoctorRate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDoctorRate() {
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
		
	    int rate =Integer.parseInt(request.getParameter("rate"));
	    int empid =Integer.parseInt(request.getParameter("empid"));

	    SQLConnect model = new SQLConnect();
	    Connection con = model.connect();
	    PreparedStatement ps = null;

	    try {
	        ps = con.prepareStatement("UPDATE doctor_rates SET rate=? WHERE doctor_id=?");
	        ps.setInt(1, rate);
	        ps.setInt(2, empid);
	       
	        ps.executeUpdate();
	        response.sendRedirect("admin/ViewDoctor.jsp");
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
