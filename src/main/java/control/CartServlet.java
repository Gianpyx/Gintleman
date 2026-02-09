package control;

import model.Cart;
import model.ProductBean;
import model.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        try {
            if ("add".equals(action)) {
                addToCart(request, response, cart);
            } else if ("remove".equals(action)) {
                removeFromCart(request, response, cart);
            } else if ("view".equals(action)) {
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, Cart cart)
            throws SQLException, IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null && !productIdStr.isEmpty()) {
            int productId = Integer.parseInt(productIdStr);
            ProductDAO productDAO = new ProductDAO();
            ProductBean product = productDAO.doRetrieveByKey(productId);

            if (product != null && product.isActive()) {
                cart.addItem(product);

                // Return JSON response for AJAX
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{");
                out.print("\"status\":\"success\",");
                out.print("\"cartCount\":" + cart.getTotalItemsCount());
                out.print("}");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found or inactive");
            }
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, Cart cart)
            throws IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null && !productIdStr.isEmpty()) {
            int productId = Integer.parseInt(productIdStr);
            cart.removeItem(productId);

            // Redirect back to cart page
            response.sendRedirect("cart.jsp");
        }
    }
}
