package control;

import model.Cart;
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

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        // 1. Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Get Cart
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("catalog.jsp"); // Retrieve URL or show empty cart message
            return;
        }

        // 3. Create Order Object
        OrderBean order = new OrderBean();
        order.setUserId(user.getId());
        order.setTotalAmount(cart.getTotalAmount());
        order.setStatus("COMPLETED");

        // 4. Save to DB
        OrderDAO orderDAO = new OrderDAO();
        try {
            orderDAO.doSave(order, cart);

            // 5. Clear Cart on success
            session.removeAttribute("cart");

            // 6. Redirect to Order History (User Area)
            response.sendRedirect("orders.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving order: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
