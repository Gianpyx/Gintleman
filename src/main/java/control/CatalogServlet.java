package control;

import model.ProductBean;
import model.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "CatalogServlet", value = "/catalog")
public class CatalogServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("load".equals(action)) {
            // AJAX Request for JSON data
            loadProductsJson(request, response);
        } else {
            // Normal Request -> Forward to catalog.jsp
            request.getRequestDispatcher("catalog.jsp").forward(request, response);
        }
    }

    private void loadProductsJson(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String nationality = request.getParameter("nationality");

        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.valueOf(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.valueOf(maxPriceStr) : null;

        ProductDAO productDAO = new ProductDAO();
        try {
            List<ProductBean> products = productDAO.doRetrieveAll(minPrice, maxPrice, nationality);

            // Manual JSON construction to avoid Gson dependency for now
            PrintWriter out = response.getWriter();
            out.print("[");
            for (int i = 0; i < products.size(); i++) {
                ProductBean p = products.get(i);
                out.print("{");
                out.print("\"id\":" + p.getId() + ",");
                out.print("\"name\":\"" + escapeJson(p.getName()) + "\",");
                out.print("\"price\":" + p.getPrice() + ",");
                out.print("\"nationality\":\"" + escapeJson(p.getNationality()) + "\",");
                out.print("\"imageUrl\":\"" + (p.getImageUrl() != null ? escapeJson(p.getImageUrl()) : "") + "\"");
                out.print("}");
                if (i < products.size() - 1)
                    out.print(",");
            }
            out.print("]");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }

    private String escapeJson(String s) {
        if (s == null)
            return "";
        return s.replace("\"", "\\\"");
    }
}
