package patientIPD;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

@WebServlet("/IpdBill")
public class IpdBill extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException 
	{
		
        List<IpdBillData> ipdBillList = new ArrayList<>();
        int ipd_appointment_id = Integer.parseInt(request.getParameter("ipd_appointment_id"));
        request.setAttribute("ipd_appointment_id", ipd_appointment_id);
        Connection connection = null;
        SQLConnect model = new SQLConnect();
        try 
        {
        	connection = model.connect();
        }
        catch(Exception e)
        {
        	e.printStackTrace();
        }
        String sql = "SELECT * FROM ipd_bill where ipd_appointment_id = ? ";
        
        
        try 
        {
        	PreparedStatement preparedStatement = connection.prepareStatement(sql);
    		preparedStatement.setInt(1,ipd_appointment_id);
    		ResultSet resultSet = preparedStatement.executeQuery();
    		int totbill = 0;
    		int totpaid = 0 ;
    		int totamt = 0 ;
            // Process the result set
            while (resultSet.next()) 
            {
                int amount = resultSet.getInt("amount");
                String reason = resultSet.getString("reason");
                java.sql.Timestamp date = resultSet.getTimestamp("date");

                // Create an IpdBillData object
                IpdBillData ipdBillData = new IpdBillData( amount, reason, date);

                // Add the object to the list
                ipdBillList.add(ipdBillData);
                if(resultSet.getString("reason").equals("paid")) 
                {
                	totpaid = totpaid + amount ;
                }//if
                else
                {
                	totbill = totbill + amount;
                }//else
            }//while
            totamt = totbill - totpaid;
            request.setAttribute("totbill", totbill);
            request.setAttribute("totpaid", totpaid);
            request.setAttribute("totamt", totamt);


            // Close resources
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
     // Store the list in the request
        request.setAttribute("ipdBillList", ipdBillList);

        // Forward the request to the JSP page
        request.getRequestDispatcher("patient/ipd_bill.jsp").forward(request, response);


		
	}// doPost

}// IpdBill