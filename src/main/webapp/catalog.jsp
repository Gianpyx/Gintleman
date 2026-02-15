<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Catalogo - Gintleman</title>
    <!-- Usa index.css come base comune per reset e variabili -->
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/catalog.css">
    <link rel="stylesheet" href="css/style.css"> <!-- Base Globale -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="catalog-container">
    <!-- Sidebar Filters -->
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

    <!-- Product Grid -->
    <main id="product-grid" class="catalog-grid">
        <!-- Products will be loaded here via AJAX -->
        <p>Caricamento prodotti...</p>
    </main>
</div>

<%@ include file="footer.jsp" %>

<style>
    /* Custom Toast Notification */
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
        background-color: #28a745; /* Green for success */
    }
    
    #toast-notification.error {
        background-color: #dc3545; /* Red for error */
    }
</style>

<div id="toast-notification">Prodotto aggiunto al carrello!</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Parse URL parameters to set initial filter state
        const params = new URLSearchParams(window.location.search);
        
        // Handle 'nationality' parameters (can be multiple)
        const nationalities = params.getAll('nationality');
        
        // Iterate over all checkboxes and check them if their value is in the URL list
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
        
        // Collect all checked nationalities
        const checkboxes = document.querySelectorAll('input[name="nationality"]:checked');
        
        const params = new URLSearchParams();
        params.append('action', 'load');
        if (minPrice) params.append('minPrice', minPrice);
        if (maxPrice) params.append('maxPrice', maxPrice);
        
        checkboxes.forEach((checkbox) => {
            params.append('nationality', checkbox.value);
        });

        // Update the browser URL to reflect the current filters (without reloading)
        const displayParams = new URLSearchParams(params);
        displayParams.delete('action'); // Don't show 'action=load' in the address bar
        const newUrl = window.location.pathname + '?' + displayParams.toString();
        window.history.pushState({}, '', newUrl);

        // Add cache-busting timestamp for the AJAX request
        params.append('_t', new Date().getTime());

        console.log("Loading products with params:", params.toString());

        fetch('catalog?' + params.toString())
            .then(response => {
                if (!response.ok) throw new Error("Errore nel caricamento");
                return response.json();
            })
            .then(data => {
                const grid = document.getElementById("product-grid");
                grid.innerHTML = ""; // Clear existing content

                if (data.length === 0) {
                    grid.innerHTML = "<p>Nessun prodotto trovato.</p>";
                    return;
                }

                data.forEach(product => {
                    const card = document.createElement("div");
                    card.className = "product-card";
                    
                    // Fallback image if none provided
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
                    // Optionally update a cart badge here if you implement one
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
