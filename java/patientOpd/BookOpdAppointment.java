package patientOpd;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import login.SQLConnect;

/**
 * Servlet implementation class BookOpdAppointment
 */
@WebServlet("/BookOpdAppointment")
public class BookOpdAppointment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookOpdAppointment() {
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
		response.getWriter().append("Served at: ")
		.append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get data from the appointment form
		int patientID = Integer.parseInt(request.getParameter("patient_id"));
		int departmentID = Integer.parseInt(request.getParameter("department_id"));
		int doctorID = Integer.parseInt(request.getParameter("doctor_id"));
		String dateString = request.getParameter("date");
		System.out.println("dateString :  "+dateString);
		String BookStatus = "not confirmed";
		Timestamp timestamp = null;
		 // Define the date format expected in the input string
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
		Connection connection = null;
		SQLConnect model = new SQLConnect();
		try {
			connection = model.connect();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Process the appointment information
		int appointmentID = processAppointment(connection, patientID, departmentID, doctorID, timestamp, BookStatus);

		if (appointmentID > 0) {
			// Forward to a success page
			System.out.println("Data inserted into table successfully.");

			HttpSession session = request.getSession();
			session.setAttribute("appointmentID", appointmentID);

			PrintWriter out = response.getWriter();
			response.setContentType("text/html");
			out.println("<p class='fs-1 fst-italic bg-danger text-center' > booked successfully .</p>");
			response.sendRedirect("../HMS_Cubeten/patient/appointments_history.jsp");

		} else {
			// Forward to an error page
			System.out.println("Data was not inserted into table successfully.");
			PrintWriter out = response.getWriter();
			response.setContentType("text/html");
			out.println("<p class='fs-1 fst-italic bg-danger text-center' > booked unsuccessfully .</p>");
			RequestDispatcher rd = request.getRequestDispatcher("patient/book_appointments.jsp");
			rd.include(request, response);
		}

	}

	private int processAppointment(Connection connection, int patientID, int departmentID, int doctorID, Timestamp timestamp,
			String bookStatus) {
		int appointmentID = 0;
		try (PreparedStatement statement = connection.prepareStatement(
				"INSERT INTO opd_appointments (patient_id, department_id, doctor_id, date, appointment_status) VALUES (?, ?, ?, ?, ?)",
				Statement.RETURN_GENERATED_KEYS)) {

			statement.setInt(1, patientID);
			statement.setInt(2, departmentID);
			statement.setInt(3, doctorID);
			statement.setTimestamp(4, timestamp);
			statement.setString(5, bookStatus);

			int rowsAffected = statement.executeUpdate();

			// Check if the appointment was successfully added to the database

			if (rowsAffected > 0) {
				try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						appointmentID = generatedKeys.getInt(1);

					}
				}
			}

		} catch (SQLException e) {
			e.printStackTrace(); // Handle SQL exception

		}
		return appointmentID;
	}

}
