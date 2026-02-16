<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Catalogo - Gintleman</title>
    
    <!-- ==================== 
         STILI E RISORSE 
         ==================== -->
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    
    <!-- Stili Comuni -->
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    
    <!-- Stili Specifici -->
    <link rel="stylesheet" href="css/catalog.css">
    <link rel="stylesheet" href="css/style.css"> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<!-- Header Gintleman -->
<%@ include file="header.jsp" %>

<div class="catalog-container">
    <!-- ==================== 
         SIDEBAR: FILTRI 
         ==================== -->
    <aside class="catalog-sidebar">
        <div class="filter-group">
            <h3>Filtra per Prezzo</h3>
            <label>Min: <input type="number" id="minPrice" class="filter-control" placeholder="0"></label>
            <label>Max: <input type="number" id="maxPrice" class="filter-control" placeholder="1000"></label>
        </div>
        
        <div class="filter-group">
            <h3>Nazionalità</h3>
            <div id="nationality-filters">
                <label style="display:block; margin-bottom: 5px;"><input type="checkbox" name="nationality" value="UK"> Regno Unito</label>
                <label style="display:block; margin-bottom: 5px;"><input type="checkbox" name="nationality" value="Italy"> Italia</label>
                <label style="display:block; margin-bottom: 5px;"><input type="checkbox" name="nationality" value="Scotland"> Scozia</label>
                <label style="display:block; margin-bottom: 5px;"><input type="checkbox" name="nationality" value="Japan"> Giappone</label>
                <label style="display:block; margin-bottom: 5px;"><input type="checkbox" name="nationality" value="Spain"> Spagna</label>
            </div>
        </div>

        <button onclick="loadProducts()" class="btn-filter">Applica Filtri</button>
    </aside>

    <!-- ==================== 
         MAIN: GRIGLIA PRODOTTI 
         ==================== -->
    <main id="product-grid" class="catalog-grid">
        <!-- I prodotti verranno caricati qui via AJAX -->
        <p>Caricamento prodotti...</p>
    </main>
</div>

<!-- Footer Gintleman -->
<%@ include file="footer.jsp" %>

<!-- ==================== 
     NOTIFICHE E STILI JS 
     ==================== -->
<style>
    /* Notifica Toast Personalizzata */
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
        background-color: #28a745; /* Verde per successo */
    }
    
    #toast-notification.error {
        background-color: #dc3545; /* Rosso per errore */
    }
</style>

<div id="toast-notification">Prodotto aggiunto al carrello!</div>

<!-- ==================== 
     LOGICA CLIENT-SIDE (AJAX) 
     ==================== -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Analizza i parametri URL per impostare lo stato iniziale dei filtri
        const params = new URLSearchParams(window.location.search);
        
        // Gestione filtri nazionalità multipli
        const nationalities = params.getAll('nationality');
        
        // Itera su tutte le checkbox e seleziona quelle presenti nell'URL
        const formCheckboxes = document.querySelectorAll('input[name="nationality"]');
        formCheckboxes.forEach(cb => {
            if (nationalities.includes(cb.value)) {
                cb.checked = true;
            }
        });

        loadProducts();
    });

    function loadProducts() {
        const minPrice = document.getElementById("minPrice").value;
        const maxPrice = document.getElementById("maxPrice").value;
        
        // Raccogli tutte le nazionalità selezionate
        const checkboxes = document.querySelectorAll('input[name="nationality"]:checked');
        
        const params = new URLSearchParams();
        params.append('action', 'load');
        if (minPrice) params.append('minPrice', minPrice);
        if (maxPrice) params.append('maxPrice', maxPrice);
        
        checkboxes.forEach((checkbox) => {
            params.append('nationality', checkbox.value);
        });

        // Aggiorna l'URL del browser per riflettere i filtri correnti (senza ricaricare)
        const displayParams = new URLSearchParams(params);
        displayParams.delete('action'); // Nascondi 'action=load' dalla barra indirizzi
        const newUrl = window.location.pathname + '?' + displayParams.toString();
        window.history.pushState({}, '', newUrl);

        // Aggiungi timestamp per evitare caching della richiesta AJAX
        params.append('_t', new Date().getTime());

        console.log("Loading products with params:", params.toString());

        fetch('catalog?' + params.toString())
            .then(response => {
                if (!response.ok) throw new Error("Errore nel caricamento");
                return response.json();
            })
            .then(data => {
                const grid = document.getElementById("product-grid");
                grid.innerHTML = ""; // Pulisci contenuto esistente

                if (data.length === 0) {
                    grid.innerHTML = "<p>Nessun prodotto trovato.</p>";
                    return;
                }

                data.forEach(product => {
                    const card = document.createElement("div");
                    card.className = "product-card";
                    
                    // Immagine di fallback se non presente
                    const imgUrl = product.imageUrl ? product.imageUrl : 'img/default-bottle.png';

                    const isDisabled = product.stock <= 0 ? 'disabled' : '';
                    card.innerHTML = 
                        '<a href="product?id=' + product.id + '" style="text-decoration: none; color: inherit;">' +
                            '<img src="' + imgUrl + '" alt="' + product.name + '" class="product-image">' +
                            '<div class="product-name">' + product.name + '</div>' +
                        '</a>' +
                        '<div class="product-nationality">' + product.nationality + '</div>' +
                        '<div class="product-price">€ ' + product.price.toFixed(2) + '</div>' +
                        '<button class="btn-add-cart" onclick="addToCart(' + product.id + ')" ' + isDisabled + '>Aggiungi al Carrello</button>';
                    grid.appendChild(card);
                });
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById("product-grid").innerHTML = "<p>Errore nel caricamento dei prodotti.</p>";
            });
    }

    function addToCart(productId) {
        fetch('cart?action=add&productId=' + productId, { credentials: 'include' })
            .then(response => {
                if (!response.ok) throw new Error("Errore nell'aggiunta al carrello");
                return response.json();
            })
            .then(data => {
                if(data.status === "success") {
                    showToast("Prodotto aggiunto al carrello!", "success");
                    // Qui potresti aggiornare un badge del carrello se implementato
                } else {
                    showToast("Errore: " + (data.message || "Impossibile aggiungere"), "error");
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast("Errore di comunicazione col server", "error");
            });
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
