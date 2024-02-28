package doctor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

/**
 * Servlet implementation class IpdPrescriptions
 */
@WebServlet("/IpdPrescriptions")
public class IpdPrescriptions extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IpdPrescriptions() {
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
		ResultSet rs = null;

		
		String age = "";
		String name = "";
		String gender = "";
		String ward_name = "";
		String checkin_date = "";
		String status = "";
		String doctor = "";
		String nurse = "";
		int appointmentid = Integer.parseInt(request.getParameter("ipd_appointment_id"));
		name = request.getParameter("name");
		age = request.getParameter("age");
		gender = request.getParameter("gender");
		ward_name = request.getParameter("ward_name");
		checkin_date = request.getParameter("checkin_date");
		status = request.getParameter("status");
		doctor = request.getParameter("doctor");
		nurse = request.getParameter("nurse");
		System.out.println("nurse name in servlet: " + nurse);
		
		int medicine_id = 0 ; 
		String medicine_name = request.getParameter("medication");
		int dose = Integer.parseInt(request.getParameter("dose"));
		int frequency = Integer.parseInt(request.getParameter("frequency"));
		int duration = Integer.parseInt(request.getParameter("duration"));
		String test = request.getParameter("test");
		String recommendation =request.getParameter("recommendation");
		
		try {
			ps = con.prepareStatement("select medicine_id from medicines where medicine_name=?");
			ps.setString(1, medicine_name);			
			rs = ps.executeQuery();
			if(rs.next()) {
				medicine_id = rs.getInt("medicine_id");
			}

			
		}catch(Exception e) 
		{
			e.printStackTrace();
		}

		

		try {
			ps = con.prepareStatement("INSERT INTO ipd_prescription (ipd_appointment_id,medicine_id,dose,frequency,duration,doctor_notes,test_required,date) VALUES( ?,?,?,?,?,?,?,NOW() )");
			
			ps.setInt(1, appointmentid);
			ps.setInt(2, medicine_id);
			ps.setInt(3, dose);
			ps.setInt(4, frequency);
			ps.setInt(5, duration);
			ps.setString(6, recommendation);			
			ps.setString(7, test);
			ps.executeUpdate();
			System.out.println("updated");
			
			response.sendRedirect("doctor/acknowledge_ipd.jsp?ipd_appointment_id="+appointmentid+"&name="+name+"&age="+age+"&gender="+gender+"&ward_name="+ward_name+"&checkin_date="+checkin_date+"&status="+status+"&doctor="+doctor+"&nurse="+nurse);
			
		} catch (Exception e) {
			System.out.println("exception in prescription.java in doctor pk . ");
			e.printStackTrace();
			request.getRequestDispatcher("doctor/patienthistory.jsp")
			.forward(request, response);		
		}
	}
}
