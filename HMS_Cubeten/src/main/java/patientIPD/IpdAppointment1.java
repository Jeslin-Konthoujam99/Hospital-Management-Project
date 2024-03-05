package patientIPD;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

/**
 * Servlet implementation class IpdAppointment1
 */
@WebServlet("/IpdAppointment1")
public class IpdAppointment1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IpdAppointment1() {
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
		
		System.out.println("in ipd appointment seervlet");

		SQLConnect obj=new SQLConnect();
		Connection con=obj.connect();
		PreparedStatement ps=null;
		
		int patient_id=Integer.parseInt( request.getParameter("patientID"));
		int doctorid=Integer.parseInt( request.getParameter("doctorid"));
		int nurseid=Integer.parseInt(request.getParameter("nurseid"));
		int ward_id=Integer.parseInt(request.getParameter("ward_id"));
		String dateString = request.getParameter("date");
		System.out.println("dateString :  "+dateString);
		Timestamp timestamp = null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        try {
            // Parse the input string to obtain a Date object
            Date parsedDate = dateFormat.parse(dateString);
            
            // Convert the Date object to a Timestamp
             timestamp = new Timestamp(parsedDate.getTime());
            
            // Now, 'timestamp' can be used in your MySQL database
            System.out.println("Timestamp for MySQL: " + timestamp);
        } catch (ParseException e) {
            e.printStackTrace();
        }
		try {
			ps=con.prepareStatement("INSERT INTO ipd_appointment(patient_id,ward_id,doctor_id,nurse_id,checkin_date,status,residency) VALUES(?,?,?,?,?,?,?)");
			ps.setInt(1, patient_id);
			ps.setInt(2, ward_id);
			ps.setInt(3, doctorid);
			ps.setInt(4, nurseid);
			ps.setTimestamp(5, timestamp);
			ps.setString(6, "pending");
			ps.setString(7, "residing");
			ps.executeUpdate();
			response.sendRedirect("patient/viewappointment.jsp");
		}catch (Exception e) {
			System.out.println(e);
			
		}
		
	}
	

}

