package adminPk;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import login.SQLConnect;

@WebServlet("/empsalary")
public class empsalary extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            int empId = Integer.parseInt(request.getParameter("empId"));
            float salaryAmount = Float.parseFloat(request.getParameter("salaryAmount"));
            String dateTime = request.getParameter("dateTime");

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = dateFormat.parse(dateTime);
            java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());

            SQLConnect model = new SQLConnect();
            connection = model.connect();

            String sqlQuery = "UPDATE hmss.employee_salary SET salary = ?, salary_date = ? WHERE employee_id = ?";
            preparedStatement = connection.prepareStatement(sqlQuery);

            preparedStatement.setFloat(1, salaryAmount);
            preparedStatement.setDate(2, sqlDate);
            preparedStatement.setInt(3, empId);

            preparedStatement.executeUpdate();
            response.sendRedirect("admin/Success.jsp");

           
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }
}
