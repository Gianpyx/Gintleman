<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="model.OrderBean" %>
<%@ page import="java.util.List" %>
<%@ page import="model.UserBean" %>
<%@ page import="java.text.SimpleDateFormat" %>

<html>
<head>
    <title>Gintleman - I tuoi ordini</title>
    
    <!-- ==================== 
         STILI E RISORSE 
         ==================== -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    
    <style>
        .orders-container {
            max-width: 1000px;
            margin: 120px auto 40px;
            padding: 20px;
        }
        .orders-table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .orders-table th, .orders-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .orders-table th {
            background-color: #333;
            color: white;
        }
        .status-completed {
            color: green;
            font-weight: bold;
        }
        .empty-history {
            text-align: center;
            padding: 40px;
            color: #777;
        }
    </style>
</head>
<body>

<!-- Header Gintleman -->
<%@ include file="header.jsp" %>

<div class="orders-container">
    <h1>I tuoi Ordini</h1>
    
    <!-- ==================== 
         LOGICA GESTIONE ORDINI 
         ==================== -->
    <%
        UserBean currentUser = (UserBean) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        List<OrderBean> orders = orderDAO.doRetrieveByUser(currentUser.getId());
        
        if (orders.isEmpty()) {
    %>
        <!-- Caso: Storico Vuoto -->
        <div class="empty-history">
            <h3>Non hai ancora effettuato ordini.</h3>
            <a href="catalog.jsp" class="scopri_di_piu" style="display:inline-block; font-size: 1rem; margin-top: 20px;">Vai allo Shopping</a>
        </div>
    <%
        } else {
    %>
        <!-- ==================== 
             TABELLA ORDINI 
             ==================== -->
        <table class="orders-table">
            <thead>
                <tr>
                    <th>Ordine #</th>
                    <th>Data</th>
                    <th>Stato</th>
                    <th>Totale</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                    for (OrderBean order : orders) { 
                %>
                <tr>
                    <td>#<%= order.getId() %></td>
                    <td><%= sdf.format(order.getCreatedAt()) %></td>
                    <td><span class="status-completed"><%= order.getStatus() %></span></td>
                    <td>€ <%= order.getTotalAmount() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>

<!-- Footer Gintleman -->
<%@ include file="footer.jsp" %>

</body>
</html>
