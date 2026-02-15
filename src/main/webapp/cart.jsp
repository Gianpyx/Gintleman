<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
    <title>Carrello - Gintleman</title>
    <!-- Usa index.css come base comune per reset e variabili anche nel carrello -->
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/cart.css"> <!-- New styles -->
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="cart-container">
    <h1>Il tuo Carrello</h1>

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <div class="empty-cart-container">
            <img src="img/Carrello_2.png" alt="Carrello Vuoto" class="empty-cart-icon">
            <h2>Il tuo carrello è vuoto</h2>
            <p>Sembra che tu non abbia ancora aggiunto nulla.</p>
            <a href="catalog.jsp" class="btn-shop">Inizia lo shopping</a>
        </div>
    <%
        } else {
    %>
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Prodotto</th>
                    <th>Prezzo</th>
                    <th>Quantità</th>
                    <th>Totale</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% for (CartItem item : cart.getItems()) { %>
                    <tr>
                        <td><%= item.getProduct().getName() %></td>
                        <td>€ <%= item.getProduct().getPrice() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>€ <%= item.getTotalPrice() %></td>
                        <td>
                            <a href="cart?action=remove&productId=<%= item.getProduct().getId() %>" class="btn-remove">Rimuovi</a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <div class="cart-total">
            Totale Ordine: € <%= cart.getTotalAmount() %>
        </div>

        <a href="checkout" class="btn-checkout">Procedi al Checkout</a>
    <%
        }
    %>
</div>

</body>
</html>
