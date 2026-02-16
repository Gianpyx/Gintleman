<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserBean" %>
<%@ page import="model.OrderBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!-- ==================== 
     LOGICA DI CONTROLLO 
     ==================== -->
<%
    UserBean user = (UserBean) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<OrderBean> orders = (List<OrderBean>) request.getAttribute("orders");
    OrderBean selectedOrder = (OrderBean) request.getAttribute("selectedOrder");
    String orderError = (String) request.getAttribute("orderError");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    String success = request.getParameter("success");
%>

<html>
<head>
    <title>Il Mio Account - Gintleman</title>
    
    <!-- ==================== 
         STILI E RISORSE 
         ==================== -->
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    
    <!-- Riutilizzo CSS Admin per layout condiviso -->
    <link rel="stylesheet" href="css/admin.css">
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .profile-container {
            max-width: 800px;
        }
        .form-readonly {
            background-color: #f0f0f0;
            cursor: not-allowed;
            color: #666;
        }
        .btn-edit-toggle {
            background-color: #0B0E0D;
            color: white;
            padding: 1rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            border: none;
            cursor: pointer;
            margin-top: 1rem;
            transition: background 0.3s;
        }
        .btn-edit-toggle:hover {
            background-color: #222;
        }
        .hidden-section {
            display: none;
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .order-table th, .order-table td {
            padding: 1.2rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .badge-completed { background: #d4edda; color: #155724; }
        .success-msg {
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            font-weight: 500;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #444;
        }
        .form-control {
            width: 100%;
            padding: 0.9rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            border-color: #0B0E0D;
            outline: none;
        }
    </style>
</head>
<body>

<!-- Header Gintleman -->
<%@ include file="header.jsp" %>

<div class="admin-wrapper">
    <!-- Sidebar Utente -->
    <jsp:include page="user_sidebar.jsp" />

    <main class="admin-content">
        <div class="admin-header">
            <h1>Ciao, <%= user.getFirstName() %>!</h1>
            <p>Il tuo portale personale Gintleman.</p>
        </div>

        <% if ("1".equals(success)) { %>
            <div class="success-msg">Profilo aggiornato con successo!</div>
        <% } %>

        <!-- ==================== 
             SEZIONE PROFILO 
             ==================== -->
        <section id="section-profile" class="admin-card profile-container">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2 style="margin:0;">Informazioni Account</h2>
                <button type="button" class="btn-edit-toggle" id="btn-enable-edit" onclick="enableEditing()">Modifica Dati</button>
            </div>
            
            <form action="dashboard?action=updateProfile" method="post" id="profileForm">
                <div class="form-row">
                    <div class="form-group">
                        <label>Nome</label>
                        <input type="text" name="firstName" id="p_firstName" value="<%= user.getFirstName() %>" class="form-control" disabled required>
                    </div>
                    
                    <div class="form-group">
                        <label>Cognome</label>
                        <input type="text" name="lastName" id="p_lastName" value="<%= user.getLastName() %>" class="form-control" disabled required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Email (Login)</label>
                    <input type="email" value="<%= user.getEmail() %>" class="form-control form-readonly" readonly>
                    <small>L'indirizzo email non può essere cambiato per motivi di sicurezza.</small>
                </div>
                
                <div class="form-group">
                    <label>Aggiorna Password</label>
                    <input type="password" name="password" id="p_password" class="form-control" disabled placeholder="Lascia vuoto per mantenere la attuale">
                </div>

                <div id="save-action" class="hidden-section" style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #eee; text-align: right;">
                    <button type="submit" class="btn-edit-toggle" style="background-color: #28a745;">Salva Modifiche</button>
                </div>
            </form>
        </section>

        <!-- ==================== 
             SEZIONE ORDINI 
             ==================== -->
        <section id="section-orders" class="admin-card hidden-section">
            <h2 style="margin-bottom: 2rem;">Cronologia Ordini</h2>
            <div class="table-responsive">
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>ID Ordine</th>
                            <th>Data Acquisto</th>
                            <th>Importo Totale</th>
                            <th>Stato Spedizione</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (orders != null && !orders.isEmpty()) {
                            for (OrderBean o : orders) {
                    %>
                        <tr>
                            <td>#<%= o.getId() %></td>
                            <td><%= sdf.format(o.getCreatedAt()) %></td>
                            <td><strong>€ <%= o.getTotalAmount() %></strong></td>
                            <td>
                                <span class="badge badge-completed">
                                    <%= o.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <a href="dashboard?orderId=<%= o.getId() %>" class="btn-edit-toggle" style="padding: 0.5rem 1rem; font-size: 0.9rem; margin:0;">Dettagli</a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" style="text-align:center; padding: 2rem; color: #666;">Non hai ancora effettuato ordini su Gintleman.</td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<!-- ==================== 
     MODAL DETTAGLI (Solo se richiesto) 
     ==================== -->
<% if (selectedOrder != null) { %>
    <div id="orderModal" class="admin-card" style="position: fixed; top: 10%; left: 10%; width: 80%; height: 80%; z-index: 1000; overflow-y: auto; box-shadow: 0 0 50px rgba(0,0,0,0.5);">
         <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 2rem;">
            <h2 style="margin:0;">Dettagli Ordine #<%= selectedOrder.getId() %></h2>
            <button class="btn-edit-toggle" style="background-color: #dc3545; margin:0;" onclick="window.location.href='dashboard'">Chiudi</button>
        </div>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
            <div>
                <h3 style="border-bottom: 1px solid #eee; padding-bottom: 0.5rem;">Dati Spedizione</h3>
                <p><strong>Indirizzo:</strong> <%= selectedOrder.getAddress() %></p>
                <p><strong>Città:</strong> <%= selectedOrder.getCity() %></p>
                <p><strong>CAP:</strong> <%= selectedOrder.getZipCode() %></p>
            </div>
            <div style="text-align: right;">
                <h3 style="border-bottom: 1px solid #eee; padding-bottom: 0.5rem;">Riepilogo</h3>
                <p><strong>Data:</strong> <%= sdf.format(selectedOrder.getCreatedAt()) %></p>
                <p><strong>Stato:</strong> <%= selectedOrder.getStatus() %></p>
                <p style="font-size: 1.5rem; color: #b12704;"><strong>Totale: € <%= selectedOrder.getTotalAmount() %></strong></p>
            </div>
        </div>

        <h3 style="border-bottom: 1px solid #eee; padding-bottom: 0.5rem; margin-bottom: 1rem;">Articoli Ordinati</h3>
        <div class="table-responsive">
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Prodotto</th>
                        <th>Quantità</th>
                        <th>Prezzo Unitario</th>
                        <th>Subtotale</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (model.OrderItemBean item : selectedOrder.getItems()) { %>
                    <tr>
                        <td><%= item.getProduct().getName() %></td>
                        <td>x<%= item.getQuantity() %></td>
                        <td>€ <%= item.getPriceAtPurchase() %></td>
                        <td>€ <%= item.getPriceAtPurchase().multiply(new java.math.BigDecimal(item.getQuantity())) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <div style="position: fixed; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.5); z-index:999;" onclick="window.location.href='dashboard'"></div>
<% } %>

<% if (orderError != null) { %>
    <script>alert('<%= orderError %>');</script>
<% } %>

<!-- ==================== 
     LOGICA CLIENT-SIDE 
     ==================== -->
<script>
    // Se atterriamo sulla pagina con un ordine selezionato, mostriamo la sezione ordini
    var autoShowOrders = "<%= (selectedOrder != null || orderError != null) %>" === "true";
    if (autoShowOrders) {
        window.onload = function() {
            showSection('orders');
        };
    }
    function enableEditing() {
        document.getElementById('p_firstName').disabled = false;
        document.getElementById('p_lastName').disabled = false;
        document.getElementById('p_password').disabled = false;
        
        document.getElementById('btn-enable-edit').style.display = 'none';
        document.getElementById('save-action').classList.remove('hidden-section');
        
        document.getElementById('p_firstName').focus();
    }

    function showSection(sectionId) {
        document.getElementById('section-profile').classList.add('hidden-section');
        document.getElementById('section-orders').classList.add('hidden-section');
        
        document.getElementById('section-' + sectionId).classList.remove('hidden-section');
        
        // Aggiorna stato attivo sidebar
        document.getElementById('link-profile').classList.remove('active');
        document.getElementById('link-orders').classList.remove('active');
        document.getElementById('link-' + sectionId).classList.add('active');
    }
</script>

</body>
</html>
