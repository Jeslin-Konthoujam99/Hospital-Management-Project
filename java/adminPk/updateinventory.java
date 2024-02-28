package adminPk;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.SQLConnect;

@WebServlet("/updateinventory")
public class updateinventory extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	 String actionWithId = request.getParameter("action");

         if (actionWithId != null) {
             // Split the action value by underscore
             String[] parts = actionWithId.split("_");

             if (parts.length == 2) {
                 String action = parts[0]; // Extract the action type
                 int itemId = Integer.parseInt(parts[1]); // Extract the item ID

                 switch (action) {
                     case "update":
                         // Call the updateInventory method with itemId
                         updateInventory(request, response, itemId);
                         break;
                     case "buy":
                         // Call the buyInventory method with itemId
                         buyInventory(request, response, itemId);
                         break;
                     case "return":
                         // Call the returnInventory method with itemId
                         returnInventory(request, response, itemId);
                         break;
                     case "delete":
                         // Call the deleteInventory method with itemId
                         deleteInventory(request, response, itemId);
                         break;
                     default:
                         response.getWriter().println("Invalid action");
                         break;
                 }
             } else {
                 response.getWriter().println("Invalid action format");
             }
         } else {
             response.getWriter().println("Action parameter is missing");
         }
     }

    private void updateInventory(HttpServletRequest request, HttpServletResponse response, int itemId)
            throws ServletException, IOException {
        String itemname = request.getParameter("itemName_" + itemId);
        String departmentName = request.getParameter("departmentId_" + itemId); // Assuming department name is provided
        String quantity = request.getParameter("quantity_" + itemId);
        String price = request.getParameter("price_" + itemId);
        String lowStockqty = request.getParameter("lowStockQuantity_" + itemId);
        String datetime = request.getParameter("date_" + itemId);
        System.out.println("itemid    :" + itemId + " date :    " + datetime);

        // Assuming datetime is in the format "yyyy-MM-dd HH:mm:ss.S"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
        LocalDateTime localDateTime = LocalDateTime.parse(datetime, formatter);

        // Convert LocalDateTime to Timestamp
        Timestamp timestamp = Timestamp.valueOf(localDateTime);
        System.out.println("Timestamp: " + timestamp);

        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();

            // Retrieve the department ID based on the department name
            int departmentId = getDepartmentId(departmentName, con);

            // Perform the update
            String updateQuery = "UPDATE inventory SET itemname = ?, departmentid = ?, quantity = ?, price = ?, lowStockqty = ?, date = ? WHERE itemid = ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(updateQuery)) {
                preparedStatement.setString(1, itemname);
                preparedStatement.setInt(2, departmentId); // Set department ID
                preparedStatement.setInt(3, Integer.parseInt(quantity));
                preparedStatement.setInt(4, Integer.parseInt(price));
                preparedStatement.setInt(5, Integer.parseInt(lowStockqty));
                preparedStatement.setTimestamp(6, timestamp);
                preparedStatement.setInt(7, itemId);

                preparedStatement.executeUpdate();
                System.out.println("Item updated successfully");

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<p class='fs-1 fc-success text-center'>Item updated successfully</p>");
                response.sendRedirect("admin/deleteinventory.jsp");
            } catch (SQLException e) {
                e.printStackTrace();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<p class='fs-1 bg-danger text-center'>Unable to update. Please retry after reload.</p>");
                RequestDispatcher rd = request.getRequestDispatcher("admin/deleteinventory.jsp");
                rd.include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

private int getDepartmentId(String departmentName, Connection con) throws SQLException {
        int departmentId = -1; // Default value if department is not found

        String selectDepartmentIdQuery = "SELECT department_id FROM department WHERE dpt_name = ?";

        try (PreparedStatement selectDepartmentIdStatement = con.prepareStatement(selectDepartmentIdQuery)) {
            selectDepartmentIdStatement.setString(1, departmentName);
            ResultSet resultSet = selectDepartmentIdStatement.executeQuery();

            if (resultSet.next()) {
                departmentId = resultSet.getInt("department_id");
            }
        }

        return departmentId;
    }

    private void buyInventory(HttpServletRequest request, HttpServletResponse response, int itemId)
            throws ServletException, IOException {
        int purchasedQuantity = Integer.parseInt(request.getParameter("buyquantity_" + itemId));

        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();

            // SQL query to update the inventory table
            String updateInventoryQuery = "UPDATE inventory SET quantity = quantity + ? WHERE itemid = ?";
            try (PreparedStatement updateInventoryStatement = con.prepareStatement(updateInventoryQuery)) {
                updateInventoryStatement.setInt(1, purchasedQuantity);
                updateInventoryStatement.setInt(2, itemId);
                updateInventoryStatement.executeUpdate();
            }

            // SQL query to update the inventorybill table
            String updateInventoryBillQuery = "INSERT INTO inventorybill (itemid, Amount, qty, date, transaction_type) VALUES (?, ?, ?, NOW(),'buy')";
            try (PreparedStatement updateInventoryBillStatement = con.prepareStatement(updateInventoryBillQuery)) {
                int pricePerItem = getPrice(itemId, con); // Get price per item
                int totalPrice = purchasedQuantity * pricePerItem;

                updateInventoryBillStatement.setInt(1, itemId);
                updateInventoryBillStatement.setInt(2, totalPrice);
                updateInventoryBillStatement.setInt(3, purchasedQuantity);
                updateInventoryBillStatement.executeUpdate();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<div class=\"alert alert-warning alert-dismissible fade show m-5\" role=\"alert\">\r\n"
                        + "  <strong>Success!!</strong>\r\n"
                        + "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\r\n"
                        + "</div>");
                response.sendRedirect("admin/deleteinventory.jsp");
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<div class=\"alert alert-warning alert-dismissible fade show m-5\" role=\"alert\">\r\n"
                    + "  <strong>Failed!!</strong>\r\n"
                    + "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\r\n"
                    + "</div>");
            
            RequestDispatcher rd = request.getRequestDispatcher("admin/deleteinventory.jsp");
            rd.include(request, response);
        }
    }

    private void returnInventory(HttpServletRequest request, HttpServletResponse response,int itemId)
            throws ServletException, IOException {
       // int itemid = Integer.parseInt(request.getParameter("itemId"));
        int quantityReturned = Integer.parseInt(request.getParameter("returnquantity_" + itemId));

        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();

            // Update the inventory table by subtracting returned quantity
            String updateInventoryQuery = "UPDATE inventory SET quantity = quantity - ? WHERE itemid = ?";
            try (PreparedStatement updateInventoryStatement = con.prepareStatement(updateInventoryQuery)) {
                updateInventoryStatement.setInt(1, quantityReturned);
                updateInventoryStatement.setInt(2, itemId);
                updateInventoryStatement.executeUpdate();
            }

            // Retrieve the price per item from the inventory table
            int pricePerItem = getPrice(itemId, con);

            // Calculate the total price for returned items
            int totalPriceReturned = quantityReturned * pricePerItem;

            // Insert a record into the inventorybill table for the return transaction
            String insertInventoryBillQuery = "INSERT INTO inventorybill (itemid, amount, qty, date, transaction_type) VALUES (?, ?, ?, NOW(), 'return')";
            try (PreparedStatement insertInventoryBillStatement = con.prepareStatement(insertInventoryBillQuery)) {
                insertInventoryBillStatement.setInt(1, itemId);
                insertInventoryBillStatement.setInt(2, totalPriceReturned);
                insertInventoryBillStatement.setInt(3, quantityReturned);
                insertInventoryBillStatement.executeUpdate();
                
                
                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<p class='fs-1 bg-danger text-center'>Updated quantity of  inventory table  and returned inventory items.</p>");
                response.sendRedirect("admin/deleteinventory.jsp");
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/deleteinventory.jsp");
            dispatcher.include(request, response);
        }
    }
    
    private void deleteInventory(HttpServletRequest request, HttpServletResponse response, int itemId)
            throws ServletException, IOException {
        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();

            // Delete related records from the inventorybill table first
            String deleteInventoryBillQuery = "DELETE FROM inventorybill WHERE itemid = ?";
            try (PreparedStatement deleteInventoryBillStatement = con.prepareStatement(deleteInventoryBillQuery)) {
                deleteInventoryBillStatement.setInt(1, itemId);
                deleteInventoryBillStatement.executeUpdate();
            }

            // Now, delete the item from the inventory table
            String deleteInventoryQuery = "DELETE FROM inventory WHERE itemid = ?";
            try (PreparedStatement deleteInventoryStatement = con.prepareStatement(deleteInventoryQuery)) {
                deleteInventoryStatement.setInt(1, itemId);
                int rowsAffected = deleteInventoryStatement.executeUpdate();

                if (rowsAffected > 0) {
                    PrintWriter out = response.getWriter();
                    response.setContentType("text/html");
                    out.println("<p class='fs-1 fc-success text-center'>Item deleted successfully</p>");
                } else {
                    PrintWriter out = response.getWriter();
                    response.setContentType("text/html");
                    out.println("<p class='fs-1 bg-danger text-center'>Item not found</p>");
                }

                // Redirect back to the deleteinventory.jsp page
                response.sendRedirect("admin/deleteinventory.jsp");
                
            }
        } catch (SQLException e) {
            e.printStackTrace();

            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<p class='fs-1 bg-danger text-center'>Unable to delete. Please retry after reload.</p>");

            // Redirect back to the deleteinventory.jsp page
            
            RequestDispatcher rd = request.getRequestDispatcher("admin/deleteinventory.jsp");
            rd.include(request, response);
        }
    }



    // Helper method to retrieve price per item from the inventory table
    private int getPrice(int itemId, Connection con) throws SQLException {
        String selectPriceQuery = "SELECT price FROM inventory WHERE itemid = ?";
        int pricePerItem = 0; // Initialize to default value

        try (PreparedStatement selectPriceStatement = con.prepareStatement(selectPriceQuery)) {
            selectPriceStatement.setInt(1, itemId);
            ResultSet priceResultSet = selectPriceStatement.executeQuery();

            if (priceResultSet.next()) {
                pricePerItem = priceResultSet.getInt("price");
            }
        }
        return pricePerItem;
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Render the page with the updated data
    	
    	     
    	 RequestDispatcher dispatcher = request.getRequestDispatcher("admin/deleteinventory.jsp");
         dispatcher.include(request, response);
         
         RequestDispatcher rd = request.getRequestDispatcher("admin/deleteinventory.jsp");
         rd.include(request, response);
    }
}


