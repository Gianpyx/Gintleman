<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserBean" %>
<%@ page import="model.OrderBean" %>
<%@ page import="model.OrderItemBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    UserBean adminUser = (UserBean) session.getAttribute("user");
    if (adminUser == null || !"ADMIN".equalsIgnoreCase(adminUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<OrderBean> orders = (List<OrderBean>) request.getAttribute("orders");
    OrderBean selectedOrder = (OrderBean) request.getAttribute("order");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<html>
<head>
    <title>Gestione Ordini - Gintleman Admin</title>
    <!-- Common Styles -->
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <!-- Admin Specific Style -->
    <link rel="stylesheet" href="css/admin.css">
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .order-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .order-table th, .order-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .order-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .order-row:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }

        .btn-action {
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9rem;
            margin-right: 0.5rem;
            display: inline-block;
        }

        .btn-view {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
            border: none;
            cursor: pointer;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-completed { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-canceled { background: #f8d7da; color: #721c24; }

        /* Modal/Overlay for Details */
        .modal-overlay {
            display: <%= selectedOrder != null ? "flex" : "none" %>;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-content {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            width: 100%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
        }
        
        .close-modal {
            position: absolute;
            top: 1rem;
            right: 1.5rem;
            font-size: 2rem;
            cursor: pointer;
            color: #aaa;
        }

        .order-details-header {
            border-bottom: 2px solid #eee;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }

        .item-list-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .item-list-table th, .item-list-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        .item-img {
            width: 40px;
            height: 40px;
            object-fit: contain;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="admin-wrapper">
    <jsp:include page="admin_sidebar.jsp" />

    <main class="admin-content">
        <div class="admin-header">
            <h1>Gestione Ordini</h1>
            <p>Visualizza e gestisci tutti gli ordini dei clienti.</p>
        </div>

        <!-- ORDER LIST -->
        <div class="admin-card" style="padding: 0;">
            <table class="order-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Data</th>
                        <th>Utente</th>
                        <th>Totale</th>
                        <th>Stato</th>
                        <th>Azioni</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (orders != null && !orders.isEmpty()) {
                        for (OrderBean o : orders) {
                %>
                    <tr class="order-row" onclick="window.location.href='admin_orders?id=<%= o.getId() %>'">
                        <td>#<%= o.getId() %></td>
                        <td><%= sdf.format(o.getCreatedAt()) %></td>
                        <td>ID: <%= o.getUserId() %></td>
                        <td><strong>€ <%= o.getTotalAmount() %></strong></td>
                        <td>
                            <span class="status-badge status-<%= o.getStatus().toLowerCase() %>">
                                <%= o.getStatus() %>
                            </span>
                        </td>
                        <td onclick="event.stopPropagation()">
                            <a href="admin_orders?id=<%= o.getId() %>" class="btn-action btn-view">Dettagli</a>
                            <form action="admin_orders?action=delete" method="post" style="display:inline;" onsubmit="return confirm('Sei sicuro di voler eliminare questo ordine?');">
                                <input type="hidden" name="id" value="<%= o.getId() %>">
                                <button type="submit" class="btn-action btn-delete">Elimina</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else if (orders != null) {
                %>
                    <tr>
                        <td colspan="6" style="text-align:center;">Nessun ordine trovato.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- MODAL DETAILS -->
<% if (selectedOrder != null) { %>
<div id="orderModal" class="modal-overlay">
    <div class="modal-content">
        <span class="close-modal" onclick="window.location.href='admin_orders'">&times;</span>
        <div class="order-details-header">
            <h2>Dettagli Ordine #<%= selectedOrder.getId() %></h2>
            <p>Effettuato il: <%= sdf.format(selectedOrder.getCreatedAt()) %></p>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
            <div>
                <h3>Informazioni Spedizione</h3>
                <p><strong>Indirizzo:</strong> <%= selectedOrder.getAddress() %></p>
                <p><strong>Città:</strong> <%= selectedOrder.getCity() %></p>
                <p><strong>CAP:</strong> <%= selectedOrder.getZipCode() %></p>
            </div>
            <div style="text-align: right;">
                <h3>Riepilogo</h3>
                <p><strong>Stato:</strong> <%= selectedOrder.getStatus() %></p>
                <p style="font-size: 1.5rem; color: #b12704;"><strong>Totale: € <%= selectedOrder.getTotalAmount() %></strong></p>
            </div>
        </div>

        <h3>Articoli</h3>
        <table class="item-list-table">
            <thead>
                <tr>
                    <th colspan="2">Prodotto</th>
                    <th>Quantità</th>
                    <th>Prezzo Unitario</th>
                    <th>Subtotale</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderItemBean item : selectedOrder.getItems()) { %>
                <tr>
                    <td style="width: 50px;">
                        <img src="<%= item.getProduct().getImageUrl() %>" class="item-img" alt="img">
                    </td>
                    <td><%= item.getProduct().getName() %></td>
                    <td>x <%= item.getQuantity() %></td>
                    <td>€ <%= item.getPriceAtPurchase() %></td>
                    <td>€ <%= item.getPriceAtPurchase().multiply(new java.math.BigDecimal(item.getQuantity())) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div style="margin-top: 2rem; text-align: right;">
             <form action="admin_orders?action=delete" method="post" style="display:inline;" onsubmit="return confirm('Sei sicuro di voler eliminare questo ordine?');">
                <input type="hidden" name="id" value="<%= selectedOrder.getId() %>">
                <button type="submit" class="btn-action btn-delete" style="padding: 0.8rem 1.5rem;">Elimina Ordine</button>
            </form>
            <button class="btn-action btn-view" style="padding: 0.8rem 1.5rem;" onclick="window.location.href='admin_orders'">Chiudi</button>
        </div>
    </div>
</div>

<script>
    // Close modal if clicking outside
    window.onclick = function(event) {
        if (event.target == document.getElementById('orderModal')) {
            window.location.href = 'admin_orders';
        }
    }
</script>
<% } %>

</body>
</html>
