package control;

import model.Cart;
import model.OrderBean;
import model.OrderDAO;
import model.OutOfStockException;
import model.ProductDAO;
import model.UserBean;
import java.util.Map;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("catalog.jsp");
            return;
        }

        // Retrieve form data
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String zipCode = request.getParameter("zipCode");

        // Create Order Object
        OrderBean order = new OrderBean();
        order.setUserId(user.getId());
        order.setTotalAmount(cart.getTotalAmount());
        order.setStatus("COMPLETED");

        // Set Shipping Info
        order.setAddress(address);
        order.setCity(city);
        order.setZipCode(zipCode);

        // Save to DB
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        try {
            // Bulk check stock before starting transaction
            productDAO.checkStockBulk(cart);

            orderDAO.doSave(order, cart);

            // Clear Cart on success
            session.removeAttribute("cart");

            // Redirect to Confirmation Page
            response.sendRedirect("thankyou.jsp");

        } catch (OutOfStockException e) {
            Map<String, Integer> unavailable = e.getUnavailableProducts();
            StringBuilder sb = new StringBuilder(
                    "I seguenti prodotti non sono disponibili nelle quantità richieste:<br>");
            for (Map.Entry<String, Integer> entry : unavailable.entrySet()) {
                sb.append("- ").append(entry.getKey()).append(" (disponibili: ").append(entry.getValue())
                        .append(" unità)<br>");
            }
            session.setAttribute("errorMessage", sb.toString());
            response.sendRedirect("checkout.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving order: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Direct access to checkout -> show form
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
}
