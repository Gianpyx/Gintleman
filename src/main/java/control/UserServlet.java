package control;

import model.UserBean;
import model.UserDAO;
import model.OrderBean;
import model.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/dashboard")
public class UserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserBean user = (session != null) ? (UserBean) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        try {
            // Retrieve Order History
            List<OrderBean> orders = orderDAO.doRetrieveByUser(user.getId());
            request.setAttribute("orders", orders);

            // OPTIONAL: Retrieve specific order details if requested
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr != null && !orderIdStr.isEmpty()) {
                int orderId = Integer.parseInt(orderIdStr);
                OrderBean order = orderDAO.doRetrieveByKey(orderId);

                // SECURITY CONTROL: Only allow viewing if the order belongs to the session user
                if (order != null && order.getUserId() == user.getId()) {
                    request.setAttribute("selectedOrder", order);
                } else {
                    // Unauthorized or not found
                    request.setAttribute("orderError", "Ordine non trovato o accesso non autorizzato.");
                }
            }

            request.getRequestDispatcher("user_dashboard.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserBean user = (session != null) ? (UserBean) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("updateProfile".equals(action)) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String password = request.getParameter("password");

            user.setFirstName(firstName);
            user.setLastName(lastName);
            if (password != null && !password.isEmpty()) {
                user.setPassword(password);
            }

            UserDAO userDAO = new UserDAO();
            try {
                userDAO.doUpdate(user);
                session.setAttribute("user", user); // Update session object
                response.sendRedirect("dashboard?success=1");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
            }
        }
    }
}
