<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Catalogo - Gintleman</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/catalog.css">
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
            <select id="nationality" class="filter-control">
                <option value="">Tutte</option>
                <option value="UK">Regno Unito</option>
                <option value="Italy">Italia</option>
                <option value="Scotland">Scozia</option>
                <option value="Japan">Giappone</option>
                <option value="Spain">Spagna</option>
            </select>
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        loadProducts();
    });

    function loadProducts() {
        const minPrice = document.getElementById("minPrice").value;
        const maxPrice = document.getElementById("maxPrice").value;
        const nationality = document.getElementById("nationality").value;

        const params = new URLSearchParams({
            action: 'load',
            minPrice: minPrice,
            maxPrice: maxPrice,
            nationality: nationality
        });

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

                    card.innerHTML = `
                        <img src="${imgUrl}" alt="${product.name}" class="product-image">
                        <div class="product-name">${product.name}</div>
                        <div class="product-nationality">${product.nationality}</div>
                        <div class="product-price">€ ${product.price.toFixed(2)}</div>
                        <button class="btn-add-cart" onclick="addToCart(${product.id})">Aggiungi al Carrello</button>
                    `;
                    grid.appendChild(card);
                });
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById("product-grid").innerHTML = "<p>Errore nel caricamento dei prodotti.</p>";
            });
    }

    function addToCart(productId) {
        // Placeholder for Add to Cart functionality (Phase 3 Part 2)
        alert("Prodotto " + productId + " aggiunto al carrello (Simulazione)");
    }
</script>

</body>
</html>
