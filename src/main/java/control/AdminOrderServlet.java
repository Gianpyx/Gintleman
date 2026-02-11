package control;

import model.OrderBean;
import model.OrderDAO;
import model.UserBean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", value = "/admin_orders")
public class AdminOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security Check
        if (!isAdmin(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String orderIdStr = request.getParameter("id");
        OrderDAO orderDAO = new OrderDAO();

        try {
            if (orderIdStr != null && !orderIdStr.isEmpty()) {
                // View specific order details
                int orderId = Integer.parseInt(orderIdStr);
                OrderBean order = orderDAO.doRetrieveByKey(orderId);
                if (order != null) {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("admin_orders.jsp").forward(request, response);
                } else {
                    response.sendRedirect("admin_orders");
                }
            } else {
                // List all orders
                List<OrderBean> orders = orderDAO.doRetrieveAll();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("admin_orders.jsp").forward(request, response);
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security Check
        if (!isAdmin(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        OrderDAO orderDAO = new OrderDAO();

        try {
            if ("delete".equals(action) && idStr != null) {
                orderDAO.doDelete(Integer.parseInt(idStr));
            }

            // Redirect back to list
            response.sendRedirect("admin_orders");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return false;
        UserBean user = (UserBean) session.getAttribute("user");
        return user != null && user.isAdmin();
    }
}
