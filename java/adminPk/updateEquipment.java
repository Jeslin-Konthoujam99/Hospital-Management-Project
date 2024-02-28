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

@WebServlet("/updateEquipment")
public class updateEquipment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actionWithId = request.getParameter("action");

        if (actionWithId != null) {
            // Split the action value by underscore
            String[] parts = actionWithId.split("_");

            if (parts.length == 2) {
                String action = parts[0]; // Extract the action type
                int equipmentId = Integer.parseInt(parts[1]); // Extract the equipment ID

                switch (action) {
                    case "update":
                        // Call the updateEquipment method with equipmentId
                        updateequipment(request, response, equipmentId);
                        break;
                    case "buy":
                        // Call the buyEquipment method with equipmentId
                        buyEquipment(request, response, equipmentId);
                        break;
                    case "return":
                        // Call the returnEquipment method with equipmentId
                        returnEquipment(request, response, equipmentId);
                        break;
                    case "delete":
                        // Call the deleteEquipment method with equipmentId
                        deleteEquipment(request, response, equipmentId);
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

    private void updateequipment(HttpServletRequest request, HttpServletResponse response, int equipmentId)
            throws ServletException, IOException {
        String equipmentName = request.getParameter("EName_" + equipmentId);
        String departmentName = request.getParameter("departmentId_" + equipmentId);
        String quantity = request.getParameter("quantity_" + equipmentId);
        String price = request.getParameter("price_" + equipmentId);
        String lowStockQuantity = request.getParameter("lowStockQuantity_" + equipmentId);
        String datetime = request.getParameter("date_" + equipmentId);

        // Assuming datetime is in the format "yyyy-MM-dd HH:mm:ss"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
        LocalDateTime localDateTime = LocalDateTime.parse(datetime, formatter);

        // Convert LocalDateTime to Timestamp
        Timestamp timestamp = Timestamp.valueOf(localDateTime);
        
        

        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();
            
            int departmentId = getDepartmentId(departmentName, con);

            String updateQuery = "UPDATE equipment SET equipmentname = ?, departmentid = ?, quantity = ?, price = ?, lowStockqty = ?, date = ? WHERE equipmentid = ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(updateQuery)) {
                preparedStatement.setString(1, equipmentName);
                preparedStatement.setInt(2, departmentId);
                preparedStatement.setInt(3, Integer.parseInt(quantity));
                preparedStatement.setInt(4, Integer.parseInt(price));
                preparedStatement.setInt(5, Integer.parseInt(lowStockQuantity));
                preparedStatement.setTimestamp(6, timestamp);
                preparedStatement.setInt(7, equipmentId);

                preparedStatement.executeUpdate();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<p class='fs-1 fc-success text-center'>Equipment updated successfully</p>");
                response.sendRedirect("admin/deleteEquipment.jsp");
            } catch (SQLException e) {
                e.printStackTrace();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<p class='fs-1 bg-danger text-center'>Unable to update equipment. Please retry after reload.</p>");
                RequestDispatcher rd = request.getRequestDispatcher("admin/deleteEquipment.jsp");
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

    private void buyEquipment(HttpServletRequest request, HttpServletResponse response, int equipmentId)
            throws ServletException, IOException {
        int purchasedQuantity = Integer.parseInt(request.getParameter("buyquantity_" + equipmentId));

        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();

            String updateEquipmentQuery = "UPDATE equipment SET quantity = quantity + ? WHERE equipmentid = ?";
            try (PreparedStatement updateEquipmentStatement = con.prepareStatement(updateEquipmentQuery)) {
                updateEquipmentStatement.setInt(1, purchasedQuantity);
                updateEquipmentStatement.setInt(2, equipmentId);
                updateEquipmentStatement.executeUpdate();
            }

            // SQL query to update the equipment bill table
            String updateEquipmentBillQuery = "INSERT INTO equipmentbill (equipmentid, Amount, qty, date, transaction_type) VALUES (?, ?, ?, NOW(), 'buy')";
            try (PreparedStatement updateEquipmentBillStatement = con.prepareStatement(updateEquipmentBillQuery)) {
                int pricePerItem = getPrice(equipmentId, con); // Get price per item
                int totalPrice = purchasedQuantity * pricePerItem;

                updateEquipmentBillStatement.setInt(1, equipmentId);
                updateEquipmentBillStatement.setInt(2, totalPrice);
                updateEquipmentBillStatement.setInt(3, purchasedQuantity);
                updateEquipmentBillStatement.executeUpdate();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<div class=\"alert alert-warning alert-dismissible fade show m-5\" role=\"alert\">\r\n"
                        + "  <strong>Success!!</strong>\r\n"
                        + "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\r\n"
                        + "</div>");
                response.sendRedirect("admin/deleteEquipment.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<div class=\"alert alert-warning alert-dismissible fade show m-5\" role=\"alert\">\r\n"
                    + "  <strong>Failed!!</strong>\r\n"
                    + "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\r\n"
                    + "</div>");

            RequestDispatcher rd = request.getRequestDispatcher("admin/deleteEquipment.jsp");
            rd.include(request, response);
        }
    }

    private void returnEquipment(HttpServletRequest request, HttpServletResponse response, int equipmentId)
            throws ServletException, IOException {
        int quantityReturned = Integer.parseInt(request.getParameter("returnquantity_" + equipmentId));

        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();

            String updateEquipmentQuery = "UPDATE equipment SET quantity = quantity - ? WHERE equipmentid = ?";
            try (PreparedStatement updateEquipmentStatement = con.prepareStatement(updateEquipmentQuery)) {
                updateEquipmentStatement.setInt(1, quantityReturned);
                updateEquipmentStatement.setInt(2, equipmentId);
                updateEquipmentStatement.executeUpdate();
            }

            int pricePerItem = getPrice(equipmentId, con);

            int totalPriceReturned = quantityReturned * pricePerItem;

            String insertEquipmentBillQuery = "INSERT INTO equipmentbill (equipmentid, amount, qty, date, transaction_type) VALUES (?, ?, ?, NOW(), 'return')";
            try (PreparedStatement insertEquipmentBillStatement = con.prepareStatement(insertEquipmentBillQuery)) {
                insertEquipmentBillStatement.setInt(1, equipmentId);
                insertEquipmentBillStatement.setInt(2, totalPriceReturned);
                insertEquipmentBillStatement.setInt(3, quantityReturned);
                insertEquipmentBillStatement.executeUpdate();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<p class='fs-1 bg-danger text-center'>Updated quantity of equipment table  and returned equipment items.</p>");
                response.sendRedirect("admin/deleteEquipment.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/deleteEquipment.jsp");
            dispatcher.include(request, response);
        }
    }

    private void deleteEquipment(HttpServletRequest request, HttpServletResponse response, int equipmentId)
            throws ServletException, IOException {
        try {
            SQLConnect model = new SQLConnect();
            Connection con = model.connect();

            String deleteEquipmentBillQuery = "DELETE FROM equipmentbill WHERE equipmentid = ?";
            try (PreparedStatement deleteEquipmentBillStatement = con.prepareStatement(deleteEquipmentBillQuery)) {
                deleteEquipmentBillStatement.setInt(1, equipmentId);
                deleteEquipmentBillStatement.executeUpdate();
            }

            String deleteEquipmentQuery = "DELETE FROM equipment WHERE equipmentid = ?";
            try (PreparedStatement deleteEquipmentStatement = con.prepareStatement(deleteEquipmentQuery)) {
                deleteEquipmentStatement.setInt(1, equipmentId);
                int rowsAffected = deleteEquipmentStatement.executeUpdate();

                if (rowsAffected > 0) {
                    PrintWriter out = response.getWriter();
                    response.setContentType("text/html");
                    out.println("<p class='fs-1 fc-success text-center'>Equipment deleted successfully</p>");
                } else {
                    PrintWriter out = response.getWriter();
                    response.setContentType("text/html");
                    out.println("<p class='fs-1 bg-danger text-center'>Equipment not found</p>");
                }

                response.sendRedirect("admin/deleteEquipment.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();

            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<p class='fs-1 bg-danger text-center'>Unable to delete equipment. Please retry after reload.</p>");

            RequestDispatcher rd = request.getRequestDispatcher("admin/deleteEquipment.jsp");
            rd.include(request, response);
        }
    }

    private int getPrice(int equipmentId, Connection con) throws SQLException {
        String selectPriceQuery = "SELECT price FROM equipment WHERE equipmentid = ?";
        int pricePerItem = 0;

        try (PreparedStatement selectPriceStatement = con.prepareStatement(selectPriceQuery)) {
            selectPriceStatement.setInt(1, equipmentId);
            ResultSet priceResultSet = selectPriceStatement.executeQuery();

            if (priceResultSet.next()) {
                pricePerItem = priceResultSet.getInt("price");
            }
        }
        return pricePerItem;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/deleteEquipment.jsp");
        dispatcher.include(request, response);

        RequestDispatcher rd = request.getRequestDispatcher("admin/deleteEquipment.jsp");
        rd.include(request, response);
    }
}
