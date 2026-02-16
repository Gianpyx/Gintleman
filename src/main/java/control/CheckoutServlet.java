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
    // Gestione del processo di acquisto (checkout)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        // Controllo di sicurezza: l'utente deve essere loggato
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        // Controllo validità carrello: deve esistere e non essere vuoto
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("catalog.jsp");
            return;
        }

        // Recupero dati del modulo di spedizione
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String zipCode = request.getParameter("zipCode");

        // Creazione dell'oggetto Ordine con i dati dell'utente e il totale
        OrderBean order = new OrderBean();
        order.setUserId(user.getId());
        order.setTotalAmount(cart.getTotalAmount());
        order.setStatus("COMPLETED");

        // Impostazione informazioni di spedizione
        order.setAddress(address);
        order.setCity(city);
        order.setZipCode(zipCode);

        // Salvataggio su DB
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        try {
            // Controllo massivo della disponibilità prodotti (Check Stock Bulk)
            productDAO.checkStockBulk(cart);

            orderDAO.doSave(order, cart);

            // Svuotamento carrello dopo successo ordine
            session.removeAttribute("cart");

            // Redirect alla pagina di conferma
            response.sendRedirect("thankyou.jsp");

        } catch (OutOfStockException e) {
            // Gestione errore stock insufficiente: ritorno al checkout con dettagli
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
        // Accesso diretto alla pagina di checkout per mostrare il form
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
}
