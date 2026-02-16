package control;

import model.ProductBean;
import model.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {

    // Visualizzazione dettaglio singolo prodotto
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                ProductDAO productDAO = new ProductDAO();
                ProductBean product = productDAO.doRetrieveByKey(id);

                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("product.jsp").forward(request, response);
                } else {
                    // Prodotto non trovato nel database
                    response.sendRedirect("catalog.jsp");
                }
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("catalog.jsp");
            }
        } else {
            // Nessun ID fornito nella richiesta
            response.sendRedirect("catalog.jsp");
        }
    }
}
