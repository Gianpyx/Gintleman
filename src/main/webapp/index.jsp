<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gintleman - Premium Gin Shop</title>
    
    <!-- Favicon -->
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    
    <!-- Font Google: DM Sans (Simile a Google Sans) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Fogli di stile -->
    <link rel="stylesheet" href="css/style.css"> <!-- Base Globale -->
    <link rel="stylesheet" href="css/header.css"> <!-- Header -->
    <link rel="stylesheet" href="css/footer.css"> <!-- Footer -->
    <link rel="stylesheet" href="css/index.css">  <!-- SPECIFICO PER LA HOME -->
</head>

<body>

    <%@ include file="header.jsp" %>

    <!-- 1. HERO SECTION -->
    <header id="hero">
        <div id="zona_centrale">
            <h1>GINTLEMAN</h1>
            <p>Il tuo gin, con un clic!</p>
            <a href="catalog.jsp" class="btn-hero">Scopri la Collezione</a>
        </div>
    </header>

    <!-- 2. PARTNER SECTION -->
    <section id="partners">
        <h2 class="section-title">Our Partnership</h2>
        <div class="card-grid">
            <!-- Card 1: Bombay -->
            <a href="bombay.jsp" class="card">
                <div class="card-img-container">
                    <img src="img/Bottiglia%20Gin%20Bombay.png" alt="Bombay Gin" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Bombay Sapphire</h3>
                    <p class="card-subtitle">Il più Famoso</p>
                </div>
            </a>
            
            <!-- Card 2: Gin Mare -->
            <a href="gin_mare.jsp" class="card">
                <div class="card-img-container">
                    <img src="img/Bottiglia%20Gin%20Mare.png" alt="Gin Mare" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Gin Mare</h3>
                    <p class="card-subtitle">Mediterranean Gin</p>
                </div>
            </a>

            <!-- Card 3: Monkey 47 -->
            <a href="monkey_47.jsp" class="card">
                <div class="card-img-container">
                    <img src="img/Bottiglia%20Monkey%2047.png" alt="Monkey 47" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Monkey 47</h3>
                    <p class="card-subtitle">Schwarzwald Dry Gin</p>
                </div>
            </a>

            <!-- Card 4: Malfy -->
            <a href="malfy.jsp" class="card">
                <div class="card-img-container">
                    <img src="img/Bottiglia%20Gin%20Malfy.png" alt="Malfy Gin" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Malfy</h3>
                    <p class="card-subtitle">Gin Italiano</p>
                </div>
            </a>
        </div>
    </section>

    <!-- 3. BANNER SECTION (Custom Image + Blue Card) -->
    <section id="banner-cta">
        <!-- Parte Sinistra: Immagine SVG -->
        <div class="banner-img-container">
            <img src="img/immagine_go_shopping.svg" alt="Gintleman Collection">
        </div>
        
        <!-- Parte Destra: Card Blu -->
        <a href="catalog.jsp" class="banner-card">
            <div class="banner-card-content">
                <h2 class="banner-card-title">Go Shopping</h2>
                <div class="banner-arrow">&rarr;</div>
            </div>
            <div class="banner-footer">
                Store: gintleman.it
            </div>
        </a>
    </section>

    <!-- 4. BEST SELLER SECTION -->
    <section id="bestsellers">
        <h2 class="section-title">Best Sellers</h2>
        <div class="card-grid">
            <!-- Best Seller 1: Malfy Rosa (ID: 3) -->
            <a href="product?id=3" class="card">
                <div class="card-img-container">
                    <img src="img/prodotto_malfy_rosa.png" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Malfy Rosa</h3>
                    <p class="card-subtitle">€ 29.90</p>
                </div>
            </a>
            <!-- Best Seller 2: Bombay (ID: 1) -->
            <a href="product?id=1" class="card">
                <div class="card-img-container">
                    <img src="img/prodotto_bombay.png" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Bombay Sapphire</h3>
                    <p class="card-subtitle">€ 22.50</p>
                </div>
            </a>
            <!-- Best Seller 3: Gin Mare Capri (ID: 7) -->
            <a href="product?id=7" class="card">
                <div class="card-img-container">
                    <img src="img/prodotto_gin_mare_capri.png" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Gin Mare Capri</h3>
                    <p class="card-subtitle">€ 38.00</p>
                </div>
            </a>
            <!-- Best Seller 4: Monkey 47 (ID: 5) -->
            <a href="product?id=5" class="card">
                <div class="card-img-container">
                    <img src="img/prodotto_monkey.png" class="card-img">
                </div>
                <div class="card-info">
                    <h3 class="card-title">Monkey 47 Dry</h3>
                    <p class="card-subtitle">€ 45.00</p>
                </div>
            </a>
        </div>
    </section>

    <!-- 5. CATEGORIES & REGISTRATION -->
    <section id="shop-categories">
        <a href="catalog.jsp?nationality=Italy" class="category-card">
            <img src="img/Costiera%20Amalfitana.png" alt="Gin Italiani"> <!-- Assicurati che l'img esista o usa placeholder -->
            <div class="category-label">Gin Italiani</div>
        </a>
        <a href="catalog.jsp?nationality=UK&nationality=Scotland&nationality=Japan&nationality=Spain" class="category-card">
            <img src="img/Londra.png" alt="Gin Esteri"> <!-- Assicurati che l'img esista -->
            <div class="category-label">Gin Esteri</div>
        </a>
    </section>

    <!-- 6. REGISTRATION CTA (Blue Card Style) -->
    <section id="cta-register">
        <h2>Registrati su Gintleman<br>e scopri i tuoi vantaggi.</h2>
        <a href="scopri_di_piu.jsp" class="btn-cta">Scopri tutti i vantaggi</a>
    </section>

    <%@ include file="footer.jsp" %>
    
    <!-- Script JS Specifico Home -->
    <script src="js/index.js"></script>

</body>
</html>