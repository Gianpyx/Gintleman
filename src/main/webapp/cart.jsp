<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
    <title>Carrello - Gintleman</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <style>
        .cart-container {
            max-width: 1000px;
            margin: 120px auto 40px;
            padding: 20px;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .cart-table th, .cart-table td {
            text-align: left;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }
        .cart-total {
            text-align: right;
            font-size: 1.5em;
            font-weight: bold;
            margin-top: 20px;
        }
        .btn-checkout {
            display: inline-block;
            background-color: #ffd814;
            color: #000;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            float: right;
            margin-top: 10px;
        }
        .btn-remove {
            color: red;
            text-decoration: none;
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="cart-container">
    <h1>Il tuo Carrello</h1>

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <p>Il carrello è vuoto. <a href="catalog.jsp">Torna al catalogo</a>.</p>
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

<%@ include file="footer.jsp" %>

</body>
</html>
