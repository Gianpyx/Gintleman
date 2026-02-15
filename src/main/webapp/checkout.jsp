<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Cart" %>
<%@ page import="model.UserBean" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    // Ensure user is logged in
    UserBean currentUser = (UserBean) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Ensure cart is not empty
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("catalog.jsp");
        return;
    }
%>

<html>
<head>
    <title>Checkout - Gintleman</title>
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <style>
        .checkout-container {
            max-width: 600px;
            margin: 120px auto 40px;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .checkout-container h1 {
            text-align: center;
            margin-bottom: 30px;
            font-family: 'Playfair Display', serif;
        }
        
        .form-section {
            margin-bottom: 20px;
        }
        
        .form-section label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            border-color: #d4af37;
            outline: none;
        }
        
        .summary-box {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            border-left: 4px solid #d4af37;
        }
        
        .btn-complete {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #d4af37;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-complete:hover {
            background-color: #bfa12f;
        }

        .error-alert {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .error-alert b {
            font-size: 1.1rem;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="checkout-container">
    <h1>Checkout Spedizione</h1>
    
    <%
        String errorMsg = (String) session.getAttribute("errorMessage");
        if (errorMsg != null) {
            session.removeAttribute("errorMessage");
    %>
        <div class="error-alert">
            <span>⚠️</span>
            <div><%= errorMsg %></div>
        </div>
    <%
        }
    %>
    
    <div class="summary-box">
        <h3>Riepilogo Ordine</h3>
        <p>Totale Articoli: <strong><%= cart.getTotalItemsCount() %></strong></p>
        <p>Totale da Pagare: <strong>€ <%= cart.getTotalAmount() %></strong></p>
    </div>

    <form action="checkout" method="post">
        <!-- User Identity (Hidden or Pre-filled) -->
        
        <div class="form-section">
            <h3 style="margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px;">Dati Spedizione</h3>
            <div style="display: flex; gap: 15px;">
                <div style="flex: 1;">
                    <label for="firstName">Nome</label>
                    <input type="text" id="firstName" name="firstName" class="form-control" value="<%= currentUser.getFirstName() %>" required>
                </div>
                <div style="flex: 1;">
                    <label for="lastName">Cognome</label>
                    <input type="text" id="lastName" name="lastName" class="form-control" value="<%= currentUser.getLastName() %>" required>
                </div>
            </div>
        </div>

        <div class="form-section">
            <label for="address">Indirizzo (Via/Piazza, Civico)</label>
            <input type="text" id="address" name="address" class="form-control" placeholder="es. Via Roma 10" required>
        </div>

        <div class="form-section">
            <div style="display: flex; gap: 15px;">
                <div style="flex: 2;">
                    <label for="city">Città</label>
                    <input type="text" id="city" name="city" class="form-control" required>
                </div>
                <div style="flex: 1;">
                    <label for="zipCode">CAP</label>
                    <input type="text" id="zipCode" name="zipCode" class="form-control" pattern="[0-9]{5}" title="Inserisci 5 cifre" required>
                </div>
            </div>
        </div>

        <button type="submit" class="btn-complete">Conferma e Paga</button>
    </form>
</div>

</body>
</html>
