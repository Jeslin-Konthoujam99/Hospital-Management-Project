package doctor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;


@WebServlet("/Prescriptions")
public class Prescriptions extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SQLConnect obj = new SQLConnect();
		Connection con = obj.connect();
		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		
		String age = "";
		String name = "";
		String gender = "";
		String status = "";
		String date = "";
		String doctor = "";
		String dpt_name = "";

		int appointmentid = Integer.parseInt(request.getParameter("pid") );
		int pid1 = Integer.parseInt(request.getParameter("pid1") );
		name = request.getParameter("name");
		System.out.println("name in presciption servlet: "+ name);
		age = request.getParameter("age");
		gender = request.getParameter("gender");
		status = request.getParameter("status");
		date = request.getParameter("date");
		doctor = request.getParameter("doctor");
		dpt_name = request.getParameter("dpt_name");
		
		int medicine_id = 0 ; 
		String medicine_name = request.getParameter("medication");
		String dose = request.getParameter("dose");
		String duration = request.getParameter("duration");
		String test = request.getParameter("test");
		String recommendation = request.getParameter("recommendation");

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
if (medicine_id >0)
{
		try {
			ps = con.prepareStatement("INSERT INTO opd_prescriptions (appointment_id,medicine_id,dose,duration,recommendation,test) VALUES( ?,?,?,?,?,? )");
			
			ps.setInt(1, appointmentid);
			ps.setInt(2, medicine_id);
			ps.setString(3, dose);
			ps.setString(4, duration);
			ps.setString(5, recommendation);
			ps.setString(6, test);			
			ps.executeUpdate();
			System.out.println("updated");
			
			 
			
			response.sendRedirect("doctor/acknowledge.jsp?id="+appointmentid+"&pid="+pid1+"&age="+age+"&gender="+gender+"&name="+name+"&status="+status+"&date="+date+"&doctor="+doctor+"&dpt_name="+dpt_name);
			
		} catch (Exception e) {
			System.out.println("exception in prescription.java in doctor pk . ");
			e.printStackTrace();
			request.getRequestDispatcher("doctor/patienthistory.jsp")
			.forward(request, response);		
		}
}
else
{
	try {
		ps1 = con.prepareStatement("INSERT INTO opd_prescriptions (appointment_id,recommendation,test) VALUES( ?,?,? )");
		
		ps1.setInt(1, appointmentid);
		ps1.setString(2, recommendation);
		ps1.setString(3, test);			
		ps1.executeUpdate();
		System.out.println("updated");
		
		 
		
		response.sendRedirect("doctor/acknowledge.jsp?id="+appointmentid+"&pid="+pid1+"&age="+age+"&gender="+gender+"&name="+name+"&status="+status+"&date="+date+"&doctor="+doctor+"&dpt_name="+dpt_name);
		
	} catch (Exception e) {
		System.out.println("exception in prescription.java in doctor pk . ");
		e.printStackTrace();
		request.getRequestDispatcher("doctor/patienthistory.jsp")
		.forward(request, response);		
	}

}
	}
}