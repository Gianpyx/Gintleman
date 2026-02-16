<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ProductBean" %>
<%@ page import="model.UserBean" %>
<html>
<head>
    <title>Form Prodotto - Admin</title>
    
    <!-- ==================== 
         STILI E RISORSE 
         ==================== -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    
    <style>
        .form-container {
            max-width: 600px;
            margin: 120px auto 40px;
            padding: 30px;
            background: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-control.error {
            border-color: red;
            background-color: #fff0f0;
        }
        .error-msg {
            color: red;
            font-size: 0.85em;
            display: none; /* Nascosto di default */
            margin-top: 5px;
        }
        .btn-submit {
            background-color: #333;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 1.1em;
        }
        .btn-submit:disabled {
            background-color: #999;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<!-- Header Gintleman -->
<jsp:include page="/header.jsp" />

<!-- ==================== 
     LOGICA DI ACCESSO 
     ==================== -->
<%
    UserBean user = (UserBean) session.getAttribute("user");
    if (user == null || !user.isAdmin()) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        return;
    }

    ProductBean product = (ProductBean) request.getAttribute("product");
    boolean isEdit = (product != null);
%>

<div class="form-container">
    <h1><%= isEdit ? "Modifica Prodotto" : "Nuovo Prodotto" %></h1>

    <!-- ==================== 
         FORM PRODOTTO 
         ==================== -->
    <form action="${pageContext.request.contextPath}/admin/products" method="post" id="productForm" novalidate>
        <% if(isEdit) { %>
            <input type="hidden" name="id" value="<%= product.getId() %>">
        <% } %>

        <div class="form-group">
            <label for="name">Nome Prodotto</label>
            <input type="text" id="name" name="name" class="form-control" value="<%= isEdit ? product.getName() : "" %>" required>
            <span class="error-msg">Il nome è obbligatorio (min 2 caratteri).</span>
        </div>

        <div class="form-group">
            <label for="description">Descrizione</label>
            <textarea id="description" name="description" class="form-control" rows="4" required><%= isEdit ? product.getDescription() : "" %></textarea>
            <span class="error-msg">La descrizione è obbligatoria.</span>
        </div>

        <div class="form-group">
            <label for="price">Prezzo (€)</label>
            <input type="text" id="price" name="price" class="form-control" value="<%= isEdit ? product.getPrice() : "" %>" required>
            <span class="error-msg">Inserisci un prezzo valido (es. 25.50).</span>
        </div>

        <div class="form-group">
            <label for="stock">Stock (Quantità)</label>
            <input type="number" id="stock" name="stock" class="form-control" value="<%= isEdit ? product.getStock() : "" %>" required>
            <span class="error-msg">Lo stock deve essere un numero intero positivo.</span>
        </div>

        <div class="form-group">
            <label for="nationality">Nazionalità</label>
            <input type="text" id="nationality" name="nationality" class="form-control" value="<%= isEdit ? product.getNationality() : "" %>" required>
            <span class="error-msg">La nazionalità è obbligatoria.</span>
        </div>

        <div class="form-group">
            <label for="category">Categoria</label>
            <input type="text" id="category" name="category" class="form-control" value="<%= isEdit ? product.getCategory() : "Gin" %>" required>
            <span class="error-msg">Categoria richiesta.</span>
        </div>

        <div class="form-group">
            <label for="alcoholContent">Gradazione Alcolica (%)</label>
            <input type="text" id="alcoholContent" name="alcoholContent" class="form-control" value="<%= isEdit ? product.getAlcoholContent() : "" %>" required>
            <span class="error-msg">Inserisci una gradazione valida (es. 40.5).</span>
        </div>

        <div class="form-group">
            <label for="imageUrl">URL Immagine</label>
            <input type="text" id="imageUrl" name="imageUrl" class="form-control" value="<%= isEdit ? product.getImageUrl() : "img/default-bottle.png" %>">
        </div>

        <button type="submit" class="btn-submit">Salva Prodotto</button>
    </form>
</div>

<!-- Footer Gintleman -->
<jsp:include page="/footer.jsp" />

<!-- ==================== 
     VALIDAZIONE JS CLIENT-SIDE 
     ==================== -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById("productForm");
        const inputs = form.querySelectorAll("input, textarea");

        const validators = {
            name: (val) => val.length >= 2,
            description: (val) => val.length > 0,
            price: (val) => /^\d+(\.\d{1,2})?$/.test(val) && parseFloat(val) > 0,
            stock: (val) => /^\d+$/.test(val) && parseInt(val) >= 0,
            nationality: (val) => val.length > 0,
            category: (val) => val.length > 0,
            alcoholContent: (val) => /^\d+(\.\d{1})?$/.test(val) && parseFloat(val) > 0 && parseFloat(val) <= 100
        };

        // Funzione per validare un singolo campo
        function validateField(input) {
            const name = input.name;
            if (!validators[name]) return true; // Salta campi senza validatore (es. imageUrl)
            
            const isValid = validators[name](input.value.trim());
            const errorMsg = input.nextElementSibling; // Lo span con classe error-msg

            if (!isValid) {
                input.classList.add("error");
                if (errorMsg && errorMsg.classList.contains("error-msg")) {
                    errorMsg.style.display = "block";
                }
            } else {
                input.classList.remove("error");
                if (errorMsg && errorMsg.classList.contains("error-msg")) {
                    errorMsg.style.display = "none";
                }
            }
            return isValid;
        }

        // Listener: 'input' per feedback immediato
        inputs.forEach(input => {
            input.addEventListener("input", function() {
                validateField(this);
            });
            // Valida anche su blur
            input.addEventListener("blur", function() {
                validateField(this);
            });
        });

        // Listener: 'submit' per blocco invio se invalido
        form.addEventListener("submit", function(event) {
            let isFormValid = true;
            inputs.forEach(input => {
                if (!validateField(input)) {
                    isFormValid = false;
                }
            });

            if (!isFormValid) {
                event.preventDefault(); // Blocca invio
            }
        });
    });
</script>

</body>
</html>
