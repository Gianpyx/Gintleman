<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserBean" %>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.List" %>
<!-- ==================== 
     LOGICA DI ACCESSO 
     ==================== -->
<%
    UserBean adminUser = (UserBean) session.getAttribute("user");
    if (adminUser == null || !"ADMIN".equalsIgnoreCase(adminUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Recupero lista prodotti
    List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
%>
<html>
<head>
    <title>Gestione Prodotti - Gintleman Admin</title>
    
    <!-- ==================== 
         STILI E RISORSE 
         ==================== -->
    <!-- Stili Comuni -->
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    
    <!-- Stile Specifico Admin -->
    <link rel="stylesheet" href="css/admin.css">
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">

    <!-- Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        /* ==================== 
           STILI SPECIFICI GESTIONE PRODOTTI 
           ==================== */
        .admin-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .btn-add {
            background-color: #28a745;
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            border: none;
            cursor: pointer;
        }
        
        .product-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .product-table th, .product-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .product-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .product-row:hover {
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

        .btn-edit {
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
        
        /* Modale/Overlay per Form */
        .modal-overlay {
            display: none;
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
            max-width: 600px;
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
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        .form-control {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
        }

        .product-img-preview {
            width: 50px;
            height: 50px;
            object-fit: contain;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        
        .details-view {
            display: none; /* Nascosto di default */
        }
    </style>
</head>
<body>

<!-- Header Gintleman -->
<%@ include file="header.jsp" %>

<div class="admin-wrapper">
    <!-- Sidebar Laterale -->
    <jsp:include page="admin_sidebar.jsp" />

    <main class="admin-content">
        <%-- Header & Toolbar --%>
        <div class="admin-header">
            <h1>Gestione Prodotti</h1>
            <p>Lista di tutti i prodotti disponibili.</p>
        </div>
        
        <div class="admin-toolbar">
            <button class="btn-add" onclick="openForm()">+ Aggiungi Prodotto</button>
        </div>

        <!-- ==================== 
             LISTA PRODOTTI 
             ==================== -->
        <div class="admin-card" style="padding: 0;">
            <table class="product-table">
                <thead>
                    <tr>
                        <th style="width: 60px;">Img</th>
                        <th>Nome</th>
                        <th>Prezzo</th>
                        <th>Stock</th>
                        <th>Nazionalità</th>
                        <th>Azioni</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (products != null && !products.isEmpty()) {
                        for (ProductBean p : products) {
                %>
                    <tr class="product-row" 
                        data-id="<%= p.getId() %>"
                        data-name="<%= p.getName().replace("\"", "&quot;") %>"
                        data-subtitle="<%= p.getSubtitle() != null ? p.getSubtitle().replace("\"", "&quot;") : "" %>"
                        data-desc="<%= p.getDescription().replace("\"", "&quot;").replace("\n", " ").replace("\r", " ") %>"
                        data-price="<%= p.getPrice() %>"
                        data-stock="<%= p.getStock() %>"
                        data-img="<%= p.getImageUrl() %>"
                        data-cat="<%= p.getCategory() %>"
                        data-alc="<%= p.getAlcoholContent() %>"
                        data-nat="<%= p.getNationality() %>"
                        onclick="showDetailsFromRow(this)">
                        <td><img src="<%= p.getImageUrl() %>" class="product-img-preview" alt="img"></td>
                        <td><%= p.getName() %></td>
                        <td>€ <%= p.getPrice() %></td>
                        <td><%= p.getStock() %></td>
                        <td><%= p.getNationality() %></td>
                        <td onclick="event.stopPropagation()"> <!-- Stop propagazione per prevenire click su riga -->
                            <div style="display:flex; gap:0.5rem;">
                                <button class="btn-action btn-edit" onclick="openFormFromRow(this.closest('.product-row'))">Modifica</button>
                                <button class="btn-action btn-delete" style="background:#cc0000;" onclick="zeroStock('<%= p.getId() %>')">Esaurisci</button>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6" style="text-align:center;">Nessun prodotto trovato.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- ==================== 
     MODAL FORM (AGGIUNGI/MODIFICA) 
     ==================== -->
<div id="productFormModal" class="modal-overlay">
    <div class="modal-content">
        <span class="close-modal" onclick="closeForm()">&times;</span>
        <h2 id="modalTitle">Aggiungi Prodotto</h2>
        <form id="productForm" action="admin_products?action=save" method="post">
            <input type="hidden" id="p_id" name="id">
            
            <div class="form-group">
                <label>Nome</label>
                <input type="text" id="p_name" name="name" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label>Sottotitolo</label>
                <input type="text" id="p_subtitle" name="subtitle" class="form-control" placeholder="es. London Dry Gin">
            </div>
            
            <div class="form-group">
                <label>Descrizione</label>
                <textarea id="p_description" name="description" class="form-control" rows="3"></textarea>
            </div>
            
            <div class="form-group" style="display:flex; gap:1rem;">
                <div style="flex:1;">
                    <label>Prezzo (€)</label>
                    <input type="number" step="0.01" id="p_price" name="price" class="form-control" required>
                </div>
                <div style="flex:1;">
                    <label>Stock</label>
                    <input type="number" id="p_stock" name="stock" class="form-control" required>
                </div>
            </div>

            <div class="form-group" style="display:flex; gap:1rem;">
                <div style="flex:1;">
                     <label>Nazionalità</label>
                     <input type="text" id="p_nationality" name="nationality" class="form-control">
                </div>
            </div>
            
             <div class="form-group">
                <label>Categoria</label>
                <input type="text" id="p_category" name="category" class="form-control" list="categories">
                <datalist id="categories">
                    <option value="London Dry">
                    <option value="Distilled">
                    <option value="Compound">
                    <option value="Old Tom">
                </datalist>
            </div>
            
            <div class="form-group" style="display:none;">
                <label>Gradazione (%)</label>
                <input type="number" step="0.1" id="p_alcohol" name="alcoholContent" class="form-control">
            </div>
            
            <div class="form-group">
                <label>URL Immagine</label>
                <input type="text" id="p_imageUrl" name="imageUrl" class="form-control" placeholder="es. img/nome_file.png">
                <small style="color:#666;">Lasciare vuoto per immagine generica</small>
            </div>
            
            <button type="submit" class="btn-add" style="width:100%;">Salva Prodotto</button>
        </form>
    </div>
</div>

<!-- ==================== 
     MODAL DETTAGLI 
     ==================== -->
<div id="detailsModal" class="modal-overlay">
    <div class="modal-content">
        <span class="close-modal" onclick="closeDetails()">&times;</span>
        <h2 id="d_name">Dettagli Prodotto</h2>
        <div style="display:flex; gap: 2rem; margin-bottom: 2rem;">
            <img id="d_img" src="" style="width: 150px; height: 150px; object-fit: contain; border: 1px solid #eee; border-radius: 8px;">
            <div>
                    <p><strong>Sottotitolo:</strong> <span id="d_subtitle"></span></p>
                    <p><strong>Descrizione:</strong> <span id="d_desc"></span></p>
                    <p><strong>Prezzo:</strong> € <span id="d_price"></span></p>
                    <p><strong>Stock:</strong> <span id="d_stock"></span> pz</p>
                    <p><strong>Nazionalità:</strong> <span id="d_nationality"></span></p>
                    <p><strong>Categoria:</strong> <span id="d_category"></span></p>
                </div>
        </div>
        
        <div style="display: flex; gap: 1rem; justify-content: flex-end;">
            <button class="btn-action btn-delete" style="background:#cc0000; padding: 0.8rem 1.5rem;" onclick="zeroStock(document.getElementById('d_delete_id').value)">Esaurisci</button>
            <button id="btnDetailsEdit" class="btn-action btn-edit" style="padding: 0.8rem 1.5rem;">Modifica</button>
            <form action="admin_products?action=delete" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare questo prodotto?');">
                <input type="hidden" id="d_delete_id" name="id">
                <button type="submit" class="btn-action btn-delete" style="padding: 0.8rem 1.5rem;">Elimina Prodotto</button>
            </form>
        </div>
    </div>
</div>

<script>
    function openFormFromRow(row) {
        const d = row.dataset;
        openForm(d.id, d.name, d.subtitle, d.desc, d.price, d.stock, d.img, d.cat, d.alc, d.nat);
    }

    function openForm(id, name, subtitle, desc, price, stock, img, cat, alc, nat) {
        document.getElementById('productFormModal').style.display = 'flex';
        
        if (id) {
            // EDIT MODE
            document.getElementById('modalTitle').innerText = "Modifica Prodotto";
            document.getElementById('p_id').value = id;
            document.getElementById('p_name').value = name;
            document.getElementById('p_subtitle').value = subtitle;
            document.getElementById('p_description').value = desc;
            document.getElementById('p_price').value = price;
            document.getElementById('p_stock').value = stock;
            document.getElementById('p_imageUrl').value = img;
            document.getElementById('p_category').value = cat;
            document.getElementById('p_alcohol').value = alc;
            document.getElementById('p_nationality').value = nat;
        } else {
            // ADD MODE
            document.getElementById('modalTitle').innerText = "Aggiungi Prodotto";
            document.getElementById('productForm').reset();
            document.getElementById('p_id').value = "";
        }
        
        // Chiudi dettagli se aperti
        closeDetails();
    }

    function closeForm() {
        document.getElementById('productFormModal').style.display = 'none';
    }
    
    function showDetailsFromRow(row) {
        const d = row.dataset;
        showDetails(d.id, d.name, d.subtitle, d.desc, d.price, d.stock, d.img, d.cat, d.alc, d.nat);
    }

    function showDetails(id, name, subtitle, desc, price, stock, img, cat, alc, nat) {
        document.getElementById('detailsModal').style.display = 'flex';
        
        document.getElementById('d_name').innerText = name;
        document.getElementById('d_subtitle').innerText = subtitle;
        document.getElementById('d_desc').innerText = desc;
        document.getElementById('d_price').innerText = price;
        document.getElementById('d_stock').innerText = stock;
        document.getElementById('d_img').src = img;
        document.getElementById('d_category').innerText = cat;
        document.getElementById('d_nationality').innerText = nat;
        
        document.getElementById('d_delete_id').value = id;
        
        // Setup Bottone Edit nei Dettagli
        document.getElementById('btnDetailsEdit').onclick = function() {
            openForm(id, name, subtitle, desc, price, stock, img, cat, alc, nat);
        };
    }
    
    function zeroStock(id) {
        if (confirm("Vuoi azzerare lo stock di questo prodotto?")) {
            window.location.href = "admin_products?action=zeroStock&id=" + id;
        }
    }
    
    function closeDetails() {
        document.getElementById('detailsModal').style.display = 'none';
    }

    // Chiudi modale se si clicca fuori
    window.onclick = function(event) {
        if (event.target == document.getElementById('productFormModal')) {
            closeForm();
        }
        if (event.target == document.getElementById('detailsModal')) {
            closeDetails();
        }
    }
</script>

</body>
</html>
