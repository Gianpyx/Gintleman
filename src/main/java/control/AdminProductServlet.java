package control;

import model.ProductBean;
import model.ProductDAO;
import model.UserBean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminProductServlet", value = "/admin_products")
public class AdminProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security Check
        if (!isAdmin(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        try {
            // Retrieve all products (no filters)
            List<ProductBean> products = productDAO.doRetrieveAll(null, null, null);
            request.setAttribute("products", products);

            // Forward to the single JSP handling List+Form+Details
            request.getRequestDispatcher("admin_products.jsp").forward(request, response);

        } catch (SQLException e) {
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
        ProductDAO productDAO = new ProductDAO();

        try {
            if ("save".equals(action)) {
                saveProduct(request, productDAO);
            } else if ("delete".equals(action)) {
                deleteProduct(request, productDAO);
            }

            // Redirect back to list
            response.sendRedirect("admin_products");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }

    private void saveProduct(HttpServletRequest request, ProductDAO productDAO) throws SQLException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String category = request.getParameter("category");
        String alcoholStr = request.getParameter("alcoholContent");
        String nationality = request.getParameter("nationality");
        String imageUrl = request.getParameter("imageUrl");

        // Handle Image Placeholder
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            imageUrl = "img/default-bottle.png";
        }

        ProductBean product = new ProductBean();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(new BigDecimal(priceStr));
        product.setStock(Integer.parseInt(stockStr));
        product.setCategory(category);
        product.setAlcoholContent(alcoholStr != null && !alcoholStr.isEmpty() ? new BigDecimal(alcoholStr) : null);
        product.setNationality(nationality);
        product.setImageUrl(imageUrl);
        product.setActive(true);

        if (idStr != null && !idStr.isEmpty()) {
            // Update
            product.setId(Integer.parseInt(idStr));
            productDAO.doUpdate(product);
        } else {
            // New Insert
            productDAO.doSave(product);
        }
    }

    private void deleteProduct(HttpServletRequest request, ProductDAO productDAO) throws SQLException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            productDAO.doDelete(Integer.parseInt(idStr));
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
