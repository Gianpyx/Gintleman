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

    // Gestione della visualizzazione e delle operazioni rapide sul carrello
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        // Recupero della sessione o creazione di un nuovo carrello se non presente
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        try {
            // Aggiunta di un prodotto al carrello
            if ("add".equals(action)) {
                addToCart(request, response, cart);
            }
            // Rimozione di un prodotto dal carrello
            else if ("remove".equals(action)) {
                removeFromCart(request, response, cart);
            }
            // Forward alla pagina di visualizzazione del carrello
            else if ("view".equals(action)) {
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    // Delega le operazioni di manipolazione dati al metodo doGet
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    // Logica per l'aggiunta di un prodotto con controllo disponibilità e quantità
    private void addToCart(HttpServletRequest request, HttpServletResponse response, Cart cart)
            throws SQLException, IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null && !productIdStr.isEmpty()) {
            int productId = Integer.parseInt(productIdStr);
            ProductDAO productDAO = new ProductDAO();
            ProductBean product = productDAO.doRetrieveByKey(productId);

            // Verifica che il prodotto esista e sia attivo per la vendita
            if (product != null && product.isActive()) {
                int quantity = 1;
                String quantityStr = request.getParameter("quantity");
                if (quantityStr != null && !quantityStr.isEmpty()) {
                    try {
                        quantity = Integer.parseInt(quantityStr);
                        if (quantity <= 0)
                            quantity = 1;
                    } catch (NumberFormatException e) {
                        quantity = 1;
                    }
                }

                cart.addItem(product, quantity);

                String redirect = request.getParameter("redirect");
                // Successo: redirect alla pagina del carrello
                if ("cart".equals(redirect)) {
                    response.sendRedirect(request.getContextPath() + "/cart");
                }
                // Successo: risposta JSON per aggiornamento dinamico della UI
                else {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.print("{");
                    out.print("\"status\":\"success\",");
                    out.print("\"cartCount\":" + cart.getTotalItemsCount());
                    out.print("}");
                }
            }
            // Errore: prodotto non trovato o non disponibile
            else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found or inactive");
            }
        }
    }

    // Rimuove completamente un prodotto dal carrello in base all'ID
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, Cart cart)
            throws IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null && !productIdStr.isEmpty()) {
            int productId = Integer.parseInt(productIdStr);
            cart.removeItem(productId);

            // Redirect conclusivo alla pagina del carrello
            response.sendRedirect("cart.jsp");
        }
    }
}
