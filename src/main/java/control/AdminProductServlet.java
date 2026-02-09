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

@WebServlet(name = "AdminProductServlet", value = "/admin/products")
public class AdminProductServlet extends HttpServlet {

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return false;
        UserBean user = (UserBean) session.getAttribute("user");
        return user != null && user.isAdmin();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        ProductDAO productDAO = new ProductDAO();

        try {
            switch (action) {
                case "new":
                    request.getRequestDispatcher("/product_form.jsp").forward(request, response);
                    break;
                case "edit":
                    showEditForm(request, response, productDAO);
                    break;
                case "delete":
                    deleteProduct(request, response, productDAO);
                    break;
                default:
                    listProducts(request, response, productDAO);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String imageUrl = request.getParameter("imageUrl");
        String category = request.getParameter("category");
        String alcoholStr = request.getParameter("alcoholContent");
        String nationality = request.getParameter("nationality");

        ProductBean product = new ProductBean();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(new BigDecimal(priceStr));
        product.setStock(Integer.parseInt(stockStr));
        product.setImageUrl(imageUrl);
        product.setCategory(category);
        product.setAlcoholContent(new BigDecimal(alcoholStr));
        product.setNationality(nationality);
        product.setActive(true);

        ProductDAO productDAO = new ProductDAO();

        try {
            if (idStr == null || idStr.isEmpty()) {
                // Insert
                productDAO.doSave(product);
            } else {
                // Update
                product.setId(Integer.parseInt(idStr));
                productDAO.doUpdate(product);
            }
            response.sendRedirect(request.getContextPath() + "/admin/products?action=list");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response, ProductDAO dao)
            throws SQLException, ServletException, IOException {
        // Retrieve all products (active)
        // TODO: Ideally we might want to see inactive ones too in admin, but reuse
        // existing method for now
        List<ProductBean> products = dao.doRetrieveAll(null, null, null);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin_products.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, ProductDAO dao)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductBean existingProduct = dao.doRetrieveByKey(id);
        request.setAttribute("product", existingProduct);
        request.getRequestDispatcher("/product_form.jsp").forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response, ProductDAO dao)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.doDelete(id);
        response.sendRedirect("products?action=list");
    }
}
