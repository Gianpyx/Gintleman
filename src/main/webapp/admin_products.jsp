<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="model.UserBean" %>
<html>
<head>
    <title>Gestione Prodotti - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 120px auto 40px;
            padding: 20px;
        }
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn-new {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
        .products-table {
            width: 100%;
            border-collapse: collapse;
        }
        .products-table th, .products-table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .products-table th {
            background-color: #333;
            color: white;
        }
        .btn-edit {
            color: blue;
            margin-right: 10px;
            text-decoration: none;
        }
        .btn-delete {
            color: red;
            text-decoration: none;
        }
        .status-active { color: green; }
        .status-inactive { color: red; }
    </style>
</head>
<body>

<jsp:include page="/header.jsp" />

<%
    UserBean user = (UserBean) session.getAttribute("user");
    if (user == null || !user.isAdmin()) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        return;
    }
%>

<div class="admin-container">
    <div class="action-bar">
        <h1>Gestione Prodotti</h1>
        <a href="${pageContext.request.contextPath}/admin/products?action=new" class="btn-new">+ Nuovo Prodotto</a>
    </div>

    <table class="products-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Prezzo</th>
                <th>Stock</th>
                <th>Nazionalità</th>
                <th>Stato</th>
                <th>Azioni</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
                if (products != null) {
                    for (ProductBean p : products) {
            %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getName() %></td>
                <td>€ <%= p.getPrice() %></td>
                <td><%= p.getStock() %></td>
                <td><%= p.getNationality() %></td>
                <td>
                    <% if(p.isActive()) { %>
                        <span class="status-active">Attivo</span>
                    <% } else { %>
                        <span class="status-inactive">Inattivo</span>
                    <% } %>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=<%= p.getId() %>" class="btn-edit">Modifica</a>
                    
                    <% if(p.isActive()) { %>
                        <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=<%= p.getId() %>" class="btn-delete" onclick="return confirm('Sei sicuro di voler eliminare questo prodotto?');">Elimina</a>
                    <% } %>
                </td>
            </tr>
            <% 
                    }
                } 
            %>
        </tbody>
    </table>
</div>

<jsp:include page="/footer.jsp" />

</body>
</html>
