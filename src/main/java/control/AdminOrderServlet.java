package control;

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
import java.util.List;

@WebServlet(name = "AdminOrderServlet", value = "/admin_orders")
public class AdminOrderServlet extends HttpServlet {

    // Metodo gestito quando arriva una richiesta GET (visualizzazione dati)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check: se l'utente non è un amministratore, lo rimanda al login
        if (!isAdmin(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Recupera l'ID dell'ordine dai parametri della URL
        String orderIdStr = request.getParameter("id");
        OrderDAO orderDAO = new OrderDAO();

        // Verifica se è stato passato un ID specifico nell'URL
        try {
            if (orderIdStr != null && !orderIdStr.isEmpty()) {
                // dettaglio dell'ordine, se è tutto bene passa alla jsp altrimenti ricarica la
                // lista
                int orderId = Integer.parseInt(orderIdStr);
                OrderBean order = orderDAO.doRetrieveByKey(orderId);
                if (order != null) {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("admin_orders.jsp").forward(request, response);
                } else {
                    response.sendRedirect("admin_orders");
                }
            } else {
                // visualizza tutti gli ordini
                List<OrderBean> orders = orderDAO.doRetrieveAll();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("admin_orders.jsp").forward(request, response);
            }
            // Gestione errori
        } catch (SQLException | NumberFormatException e) {
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

        // Recupera l'azione da compiere e l'ID dell'ordine coinvolto
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        OrderDAO orderDAO = new OrderDAO();

        try {
            if ("delete".equals(action) && idStr != null) {
                orderDAO.doDelete(Integer.parseInt(idStr));
            }

            // Dopo l'operazione, reindirizza l'utente alla lista generale degli ordini
            response.sendRedirect("admin_orders");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }

    // Funzione di supporto per verificare se l'utente loggato è un amministratore
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        // Se non c'è una sessione, l'utente non è loggato
        if (session == null)
            return false;
        UserBean user = (UserBean) session.getAttribute("user");
        // Se non c'è un utente, l'utente non è loggato
        return user != null && user.isAdmin();
    }
}
