package nurse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;


/**
 * Servlet implementation class NurseCheckup
 */
@WebServlet("/NurseCheckupIPD")
public class NurseCheckupIPD extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NurseCheckupIPD() {
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
		SQLConnect obj = new SQLConnect();
		Connection con = obj.connect();
		PreparedStatement ps = null;
		
		String notes = request.getParameter("notes");
		int app_id =Integer.parseInt( request.getParameter("app_id"));
		String BP = request.getParameter("BP");
		String weight = request.getParameter("weight");
		String height = request.getParameter("height");
		String temperature = request.getParameter("temperature");
		String pulse = request.getParameter("pulse");
		String bmi = request.getParameter("bmi");
		String vitals = "BP : "+BP+" || Weight : "+weight+" || Height : "+height
				+" || Temperature : "+temperature+" || Pulse : "+pulse
				+" || BMI: "+bmi+" || Notes : "+notes ;
		
		

		try {
			
			ps = con.prepareStatement("INSERT INTO ipd_prescription (ipd_appointment_id,nurse_notes,date) VALUES(?,?,NOW() )");
			ps.setInt(1, app_id);
			ps.setString(2, vitals);

			ps.executeUpdate();
			System.out.println("Inserted checkup data");
			response.sendRedirect("../HMS_Cubeten/nurse/ipdpatients.jsp");

		} catch (Exception e) {
			System.out.println("some exception . vitals data not inserted : ");
			e.printStackTrace();
			response.sendRedirect("../HMS_Cubeten/nurse/ipdpatients.jsp");

		}
	}
}
