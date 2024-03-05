package labPk;

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
 * Servlet implementation class InsertIpdTestResultServlet
 */
@WebServlet("/InsertIpdTestResultServlet")
public class InsertIpdTestResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertIpdTestResultServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		String testBillIdStr = request.getParameter("testBillId");
		String ipd_prescription_idstr = request.getParameter("ipd_prescription_id");
	    String bloodType = request.getParameter("bloodType");
	    String employeeIdStr = request.getParameter("employeeId");

	    int testBillId = Integer.parseInt(testBillIdStr);
	    int employeeId = Integer.parseInt(employeeIdStr);
	    int ipd_prescription_id = Integer.parseInt(ipd_prescription_idstr);
	   
	    // Database operation
        SQLConnect model = new SQLConnect();
        Connection connection = model.connect();
        response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	   
        try 
        {
        	String sql = "INSERT INTO ipd_testResult ( blood_type, bill_id, Employee_id) VALUES (?, ?, ?)";
            
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, bloodType);
            statement.setInt(2, testBillId); 
            statement.setInt(3, employeeId);
                
            statement.executeUpdate();
            System.out.println("test result inserted");

        } 
        catch (Exception e) 
        {
            // Handle database errors
        	System.out.println("exception in testresult java . could not insert  test result... ");
        	e.printStackTrace();	
        	out.println("<br><br><br><p class='fs-1 bg-danger text-center'>Test result not inserted.</p>");
            RequestDispatcher rd = request.getRequestDispatcher("lab/insert_ipd_test_result.jsp");
            rd.include(request, response);
          
        }
        try 
        {
        	String sql = "UPDATE ipd_prescription\r\n"
					+ "SET test_required = 'blood done'\r\n"
					+ "WHERE prescription_id = ?\r\n";
            PreparedStatement statement = connection.prepareStatement(sql);
            
                statement.setInt(1, ipd_prescription_id);
               
                statement.executeUpdate();
    			System.out.println("prescription test status updated");

        } 
        catch (Exception e) 
        {
        	System.out.println("exception in insert ipd test result java . could not update prescription table... ");

            // Handle database errors
        	e.printStackTrace();	
        	out.println("<br><br><br><p class='fs-1 bg-danger text-center'>Test result not inserted.</p>");
            RequestDispatcher rd = request.getRequestDispatcher("lab/insert_ipd_test_result.jsp");
            rd.include(request, response);
          
        }
                
        out.println("<br><br><br><p class='fs-1 bg-success text-center'>Test result inserted.</p>");
        RequestDispatcher rd = request.getRequestDispatcher("lab/insert_ipd_test_result.jsp");
        rd.include(request, response);
	
	}
}
