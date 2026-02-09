<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserBean" %>
<html>
<head>
    <title>Admin Dashboard - Gintleman</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <style>
        .admin-container {
            max-width: 1000px;
            margin: 120px auto 40px;
            padding: 20px;
            text-align: center;
        }
        .admin-card {
            display: inline-block;
            width: 300px;
            padding: 40px;
            margin: 20px;
            background-color: #f4f4f4;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-decoration: none;
            color: #333;
            transition: transform 0.2s;
        }
        .admin-card:hover {
            transform: translateY(-5px);
            background-color: #e0e0e0;
        }
        .admin-card h2 {
            margin-top: 0;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
    UserBean user = (UserBean) session.getAttribute("user");
    if (user == null || !user.isAdmin()) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        return;
    }
%>

<div class="admin-container">
    <h1>Admin Dashboard</h1>
    
    <a href="admin/products?action=list" class="admin-card">
        <h2>Gestione Prodotti</h2>
        <p>Aggiungi, modifica o elimina Gin dal catalogo.</p>
    </a>

    <a href="#" class="admin-card" style="opacity: 0.5; cursor: not-allowed;">
        <h2>Gestione Utenti</h2>
        <p>Presto disponibile</p>
    </a>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
