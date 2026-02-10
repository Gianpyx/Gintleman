<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserBean" %>
<%
    UserBean adminUser = (UserBean) session.getAttribute("user");
    if (adminUser == null || !"ADMIN".equalsIgnoreCase(adminUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard - Gintleman</title>
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
</head>
<body>

<%@ include file="header.jsp" %>

<div class="admin-wrapper">
    <!-- Sidebar -->
    <jsp:include page="admin_sidebar.jsp" />

    <!-- Main Content -->
    <main class="admin-content">
        <div class="admin-header">
            <h1>Benvenuto, <%= adminUser.getFirstName() %></h1>
            <p>Pannello di controllo amministrativo</p>
        </div>

        <div class="admin-card">
            <h2>Statistiche Veloci</h2>
            <p>Qui potrai vedere un riepilogo delle attività recenti.</p>
            <!-- Content placeholder -->
        </div>
        
        <div class="admin-card">
            <h2>Azioni Recenti</h2>
            <p>Nessuna azione recente registrata.</p>
        </div>
    </main>
</div>

</body>
</html>
