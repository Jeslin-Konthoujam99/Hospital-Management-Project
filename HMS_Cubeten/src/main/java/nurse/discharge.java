package nurse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

@WebServlet("/discharge")
public class discharge extends HttpServlet {
	Connection con;

	String name = null;
	int patient_id;
	String notes = null;
	String medicines = null;

	// String name1 = null;
	// String phone1 = null;
	// String address1 = null;
	// String notes1 = null;
	// String medicines1 = null;
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id = request.getParameter("OPDID");
		int id1 = Integer.parseInt(id);// patient id in integer
		System.out.println(id1);
		String ipd_app_id = request.getParameter("OPDID2");// appointment id
		System.out.println("ipd_app_id: " + ipd_app_id);

		int ipd_app_id1 = Integer.parseInt(ipd_app_id);

		System.out.println(ipd_app_id);
		
		String name = request.getParameter("fullname");
		String age = request.getParameter("age");
		String gender = request.getParameter("gender");
		String ward_name = request.getParameter("ward_name");
		String checkin_date = request.getParameter("checkin_date");
		String status = request.getParameter("status");
		String doctor = request.getParameter("doctor");
		String nurse = request.getParameter("nurse");
		
		System.out.println(name);
		System.out.println(age);
		System.out.println(gender);
		System.out.println(ward_name);
		System.out.println(checkin_date);
		System.out.println(status);
		System.out.println(doctor);
		
		String avail = "yes";
		String residency = "checked Out";
		SQLConnect m = new SQLConnect();
		con = m.connect();

		try {

			PreparedStatement ps = con
					.prepareStatement("UPDATE ward SET  availability=? WHERE patient_id=?");
			
			ps.setString(1, avail);
			ps.setInt(2, id1);

			int row = ps.executeUpdate();
			if (row > 0) {
				System.out.println("update1 done");
				ps = con.prepareStatement("UPDATE ipd_appointment SET residency=? WHERE ipd_appointment_id=?");
				ps.setString(1, residency);
				ps.setInt(2, ipd_app_id1);
				int row1 = ps.executeUpdate();
				
				if (row1 > 1) {
					System.out.println("update2 done");
				}

			} else {
				System.out.println("not done update");
			}
			
				request.setAttribute("ipd_app_id", ipd_app_id1);
				request.setAttribute("name", name);
				request.setAttribute("age", age);
				request.setAttribute("gender", gender);
				request.setAttribute("ward_name", ward_name);
				request.setAttribute("checkin_date", checkin_date);
				request.setAttribute("status", status);
				request.setAttribute("doctor", doctor);
				request.setAttribute("nurse", nurse);

			

			RequestDispatcher rd = request.getRequestDispatcher("nurse/discharge1.jsp");
			rd.forward(request, response);

		}

		catch (Exception e) {
			e.printStackTrace();
		}

	}
}
