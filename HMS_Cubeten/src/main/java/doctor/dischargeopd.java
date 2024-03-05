package doctor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

@WebServlet("/dischargeopd")
public class dischargeopd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		Connection con;
		SQLConnect m = new SQLConnect();
		con = m.connect();
		System.out.println(con);
		

		try {

			
			int appointmentid = Integer.parseInt(request.getParameter("pid") );
			int pid1 = Integer.parseInt(request.getParameter("pid1") );
			String name = request.getParameter("name");
			System.out.println("name in presciption servlet: "+ name);
			int age = Integer.parseInt(request.getParameter("age"));
			String gender = request.getParameter("gender");
			String status = request.getParameter("status");
			String date = request.getParameter("date");
			String doctor = request.getParameter("doctor");
			String dpt_name = request.getParameter("dpt_name");
			
			request.setAttribute("appointmentid",appointmentid );
			request.setAttribute("pid1",pid1 );
			request.setAttribute("name",name );
			request.setAttribute("age",age );
			request.setAttribute("gender",gender );
			request.setAttribute("status",status );
			request.setAttribute("date",date );
			request.setAttribute("doctor",doctor );
			request.setAttribute("dpt_name",dpt_name );

			/*
			 * PreparedStatement ps =
			 * con.prepareStatement("select * from opd_prescriptions where appointment_id=?"
			 * ); ps.setInt(1, appointmentid); ResultSet rs = ps.executeQuery();
			 * 
			 * while (rs.next()) {
			 * 
			 * String bp = rs.getString("bp"); String medicines = rs.getString("medicine");
			 * String test1 = rs.getString("test"); String recommendation =
			 * rs.getNString("recommendation"); String dose = rs.getNString("dose"); String
			 * duration = rs.getNString("duration");
			 * 
			 * 
			 * request.setAttribute("bp1", bp); request.setAttribute("test1", test1);
			 * request.setAttribute("medicines1", medicines);
			 * request.setAttribute("recommendation1", recommendation);
			 * request.setAttribute("dose1", dose); request.setAttribute("duration1",
			 * duration);
			 * 
			 * 
			 * 
			 * }
			 */
			
			/*
			 * ps = con.
			 * prepareStatement("UPDATE ipd_appointment SET residency=? WHERE ipd_appointment_id=?"
			 * ); ps.setString(1, residency); ps.setInt(2, ipd_app_id1); int row =
			 * ps.executeUpdate();
			 * 
			 * if (row > 1) System.out.println("update2 done");
			 */
			

			RequestDispatcher rd = request.getRequestDispatcher("doctor/discharge2.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
