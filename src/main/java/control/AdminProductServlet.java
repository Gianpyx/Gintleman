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

    // Metodo per la visualizzazione della lista prodotti e gestione rapida stock
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Controllo di sicurezza: verifica se l'utente ha permessi amministrativi
        if (!isAdmin(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        try {
            String action = request.getParameter("action");
            // Azzeramento immediato dello stock di un prodotto
            if ("zeroStock".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("id"));
                productDAO.zeroStock(productId);
                response.sendRedirect("admin_products");
                return;
            }

            // Recupero della lista completa di tutti i prodotti presenti a sistema
            List<ProductBean> products = productDAO.doRetrieveAll(null, null, null);
            request.setAttribute("products", products);

            // Forward alla JSP che gestisce l'interfaccia di amministrazione
            request.getRequestDispatcher("admin_products.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error: " + e.getMessage());
        }
    }

    // Metodo per la manipolazione dei dati (creazione, modifica, eliminazione)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Controllo di sicurezza: accesso consentito solo agli amministratori
        if (!isAdmin(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        ProductDAO productDAO = new ProductDAO();

        try {
            // Gestione del salvataggio (nuovo o aggiornamento)
            if ("save".equals(action)) {
                saveProduct(request, productDAO);
            }
            // Gestione azzeramento stock tramite post
            else if ("zeroStock".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("id"));
                try {
                    productDAO.zeroStock(productId);
                    response.sendRedirect("admin_products");
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                            "Error zeroing stock: " + e.getMessage());
                }
            }
            // Rimozione definitiva del prodotto dal database
            else if (action.equals("delete")) {
                deleteProduct(request, productDAO);
            }

            // Ritorno alla lista prodotti dopo aver completato l'operazione
            if (!response.isCommitted()) {
                response.sendRedirect("admin_products");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }

    // Estrae i dati dalla request e decide se inserire o aggiornare il prodotto
    private void saveProduct(HttpServletRequest request, ProductDAO productDAO) throws SQLException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String category = request.getParameter("category");
        String alcoholStr = request.getParameter("alcoholContent");
        String nationality = request.getParameter("nationality");
        String subtitle = request.getParameter("subtitle");
        String imageUrl = request.getParameter("imageUrl");

        // Imposta un'immagine di default se non è stata fornita un'URL specifica
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
        product.setSubtitle(subtitle);
        product.setImageUrl(imageUrl);
        product.setActive(true);

        // Se l'ID è presente stiamo effettuando un aggiornamento, altrimenti un
        // inserimento
        if (idStr != null && !idStr.isEmpty()) {
            product.setId(Integer.parseInt(idStr));
            productDAO.doUpdate(product);
        } else {
            productDAO.doSave(product);
        }
    }

    // Elimina un prodotto identificato dal suo ID univoco
    private void deleteProduct(HttpServletRequest request, ProductDAO productDAO) throws SQLException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            productDAO.doDelete(Integer.parseInt(idStr));
        }
    }

    // Verifica la validità della sessione e il ruolo dell'utente
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return false;
        UserBean user = (UserBean) session.getAttribute("user");
        return user != null && user.isAdmin();
    }
}
