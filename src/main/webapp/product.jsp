<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${product.name} - Gintleman</title>
    
    <!-- Favicon -->
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    
    <!-- Font Google: DM Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Fogli di stile -->
    <link rel="stylesheet" href="css/index.css"> <!-- Base Globale (include variabili per header) -->
    <link rel="stylesheet" href="css/header.css"> <!-- Header -->
    <link rel="stylesheet" href="css/footer.css"> <!-- Footer -->
    <link rel="stylesheet" href="css/product.css"> <!-- SPECIFICO PAGINA PRODOTTO -->
</head>

<body>

    <%@ include file="header.jsp" %>

    <!-- PRODUCT DETAIL SECTION -->
    <main class="product-page-container">
        
        <!-- Header: Titolo e Sottotitolo -->
        <div class="product-header-group">
            <h1 class="product-title-main">${product.name}</h1>
            <p class="product-subtitle-main">${product.category}</p>
        </div>

        <!-- Grid: 3 Columns -->
        <div class="product-grid">
            
            <!-- 1. Immagine (Box Blu) -->
            <div class="product-image-box">
                <img src="${product.imageUrl != null ? product.imageUrl : 'img/default-bottle.png'}" alt="${product.name}">
            </div>

            <!-- 2. Descrizione -->
            <div class="product-description-box">
                <h2 class="desc-title">Descrizione</h2>
                <p class="desc-text">${product.description}</p>
            </div>

            <!-- 3. Buy Box (Prezzo e Pulsanti) -->
            <div class="product-buy-box">
                <p class="product-price">€ ${product.price}</p>
                
                <div>
                    <p class="shipping-info">consegna prevista entro <strong>5 giorni</strong> dall'acquisto</p>
                </div>

                <div class="availability-badge">
                    ${product.stock > 0 ? 'Disponibilità immediata' : 'Esaurito'}
                </div>

                <select class="qty-selector" id="product-quantity">
                    <option value="1">Quantità: 1</option>
                    <option value="2">Quantità: 2</option>
                    <option value="3">Quantità: 3</option>
                    <option value="4">Quantità: 4</option>
                    <option value="5">Quantità: 5</option>
                </select>

                <button class="btn-buy-outline" onclick="buyNow('${product.id}')">Acquista ora</button>
                <button class="btn-add-cart" onclick="addToCart('${product.id}')">Aggiungi al carrello</button>
            </div>

        </div>

    </main>

    <%@ include file="footer.jsp" %>

    <script src="js/index.js"></script> <!-- O script specifico se serve -->

    <!-- Toast Notification -->
    <style>
        #toast-notification {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 8px;
            padding: 16px;
            position: fixed;
            z-index: 1000;
            left: 50%;
            bottom: 30px;
            font-size: 17px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3);
            opacity: 0;
            transition: opacity 0.5s, bottom 0.5s;
        }

        #toast-notification.show {
            visibility: visible;
            opacity: 1;
            bottom: 50px;
        }
        
        #toast-notification.success {
            background-color: #28a745;
        }
        
        #toast-notification.error {
            background-color: #dc3545;
        }
    </style>
    <div id="toast-notification">Prodotto aggiunto al carrello!</div>

    <script>
        function addToCart(productId) {
            if (!productId) {
                showToast("Errore: ID prodotto mancante", "error");
                return;
            }
            const quantity = document.getElementById("product-quantity").value;
            fetch('cart?action=add&productId=' + productId + '&quantity=' + quantity, { credentials: 'include' })
                .then(response => {
                    if (!response.ok) throw new Error("Errore nell'aggiunta al carrello");
                    return response.json();
                })
                .then(data => {
                    if(data.status === "success") {
                        showToast("Prodotto aggiunto al carrello!", "success");
                    } else {
                        showToast("Errore: " + (data.message || "Impossibile aggiungere"), "error");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast("Errore di comunicazione col server", "error");
                });
        }

        function buyNow(productId) {
            if (!productId) return;
            const quantity = document.getElementById("product-quantity").value;
            window.location.href = '${pageContext.request.contextPath}/cart?action=add&productId=' + productId + '&quantity=' + quantity + '&redirect=cart';
        }

        function showToast(message, type) {
            var x = document.getElementById("toast-notification");
            x.innerText = message;
            x.className = "show " + type;
            setTimeout(function(){ x.className = x.className.replace("show", "").replace(type, ""); }, 3000);
        }
    </script>

</body>
</html>
