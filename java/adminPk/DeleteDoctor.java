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

@WebServlet("/DeleteDoctor")
public class DeleteDoctor extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String UIDAdhaar = request.getParameter("UIDAadhaar");
		SQLConnect con = new SQLConnect();
		Connection con1 = con.connect();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = con1.prepareStatement("delete from employeelist where aadhaar=?");
			ps.setString(1, UIDAdhaar);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("admin/ViewDoctor.jsp");
            } else {
                response.sendRedirect("admin/Failed.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin/Failed.jsp");
        }
    }
}
