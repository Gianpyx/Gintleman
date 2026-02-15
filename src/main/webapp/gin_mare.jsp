<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gin Mare</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">
    <link rel="stylesheet" href="css/index.css"> <!-- Base Globale -->
    <link rel="stylesheet" href="css/header.css"> <!-- Header Standard -->
    <link rel="stylesheet" href="css/footer.css"> <!-- Footer -->
    <link rel="stylesheet" href="css/gin_mare.css"> <!-- Stile specifico Gin Mare -->
    
    <!-- Font Google: DM Sans + Serif font per eleganza se serve -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<!-- 1. HERO SECTION -->
<section class="hero-section">
    <div class="hero-content">
        <h1 class="hero-title">Gin Mare</h1>
        <h2 class="hero-subtitle">Mediterranean Gin</h2>
        
        <div class="hero-bottom-left">
            <p class="hero-description">Il primo gin mediterraneo autentico.</p>
        </div>
    </div>
    
    <div class="hero-image-container">
        <img src="img/prodotto_gin_mare.png" alt="Gin Mare Bottle" class="hero-bottle">
    </div>

    <div class="hero-cta-container">
        <a href="product?id=4" class="btn-buy">BUY 35.00€</a>
    </div>
</section>

<!-- 2. ABOUT SECTION -->
<section class="about-section">
    <div class="about-container">
        <div class="about-left">
            <h2 class="about-title">About this partner</h2>
        </div>
        
        <div class="about-right">
            <div class="stats-table">
                <div class="stat-row">
                    <span class="stat-label">ORIGIN</span>
                    <span class="stat-value">SPAIN</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">FOUNDING YEARS</span>
                    <span class="stat-value">2010</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">MAIN BOTANICALS</span>
                    <span class="stat-value">OLIVE, TIMO, ROSMARINO, BASILICO</span>
                </div>
                <div class="stat-row no-border">
                    <span class="stat-label">MAIN BOTTLE</span>
                    <span class="stat-value">GIN MARE</span>
                </div>
            </div>
            
            <div class="extra-stats-grid">
                <div class="stat-box">
                    <span class="box-number">2.500.000</span>
                    <span class="box-label">casse vendute</span>
                </div>
                <div class="stat-box">
                    <span class="box-text">sito</span>
                    <span class="box-label">casse vendute</span> <!-- Placeholder text from design -->
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 3. PARTNER PRODUCT SECTION (Static 2 bottles) -->
<section class="partner-product-section">
    <div class="partner-container">
        <h2 class="section-title-white">Partner Product</h2>
        
        <div class="static-bottles-grid">
            <!-- Card 1 -->
            <div class="partner-card-static">
                <div class="card-inner">
                    <img src="img/prodotto_gin_mare.png" alt="Gin Mare" class="partner-bottle-img">
                </div>
            </div>
            
            <!-- Card 2 -->
            <div class="partner-card-static">
                <div class="card-inner">
                    <img src="img/prodotto_gin_mare_capri.png" alt="Gin Mare Capri" class="partner-bottle-img">
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>

</body>
</html>
