<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="admin-sidebar">
    <ul>
        <li><a href="admin_dashboard.jsp" class="<%= request.getRequestURI().contains("admin_dashboard.jsp") ? "active" : "" %>">Overview</a></li>
        <li><a href="admin_products" class="<%= request.getRequestURI().contains("admin_products") ? "active" : "" %>">Gestione Prodotti</a></li>
        <li><a href="admin_orders" class="<%= request.getRequestURI().contains("admin_orders") ? "active" : "" %>">Gestione Ordini</a></li>
        <li><a href="#" class="<%= request.getRequestURI().contains("admin_users") ? "active" : "" %>">Gestione Utenti</a></li>
        <li><a href="#" class="<%= request.getRequestURI().contains("admin_settings") ? "active" : "" %>">Impostazioni Sito</a></li>
        <li class="sidebar-divider"></li>
        <li><a href="logout" class="logout-link">Logout</a></li>
    </ul>
</aside>
