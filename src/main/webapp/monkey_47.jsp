<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monkey 47</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">
    <link rel="stylesheet" href="css/index.css"> <!-- Base Globale -->
    <link rel="stylesheet" href="css/header.css"> <!-- Header Standard -->
    <link rel="stylesheet" href="css/footer.css"> <!-- Footer -->
    <link rel="stylesheet" href="css/monkey_47.css"> <!-- Stile specifico Monkey 47 -->
    
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
        <h1 class="hero-title">Monkey 47</h1>
        <h2 class="hero-subtitle">Schwarzwald Dry Gin</h2>
        
        <div class="hero-bottom-left">
            <p class="hero-description">Il gin della Foresta Nera con 47 botaniche.</p>
        </div>
    </div>
    
    <div class="hero-image-container">
        <img src="img/prodotto_monkey.png" alt="Monkey 47 Bottle" class="hero-bottle">
    </div>

    <div class="hero-cta-container">
        <a href="product?id=5" class="btn-buy">BUY 45.00€</a>
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
                    <span class="stat-value">GERMANY</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">FOUNDING YEARS</span>
                    <span class="stat-value">2010</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">MAIN BOTANICALS</span>
                    <span class="stat-value">MIRTILLI ROSSI, ABETE ROSSO, SAMBUCO</span>
                </div>
                <div class="stat-row no-border">
                    <span class="stat-label">MAIN BOTTLE</span>
                    <span class="stat-value">MONKEY 47 DRY GIN</span>
                </div>
            </div>
            
            <div class="extra-stats-grid">
                <div class="stat-box">
                    <span class="box-number">1.200.000</span>
                    <span class="box-label">casse vendute</span>
                </div>
                <div class="stat-box">
                    <span class="box-text">
                        <a href="https://monkey47.com/?nl=true" target="_blank" class="brand-link">Monkey 47</a>
                    </span>
                    <span class="box-label">Original Site</span> <!-- Placeholder text from design -->
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 3. PARTNER PRODUCT SECTION (Carousel Structure 1 item) -->
<section class="partner-product-section">
    <div class="partner-container">
        <h2 class="section-title-white">Partner Product</h2>
        
        <div class="carousel-wrapper">
            <div class="carousel-track">
                <!-- Card 1 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_monkey.png" alt="Monkey 47" class="partner-bottle-img">
                    </div>
                </div>
            </div>
            <!-- No Nav Button needed for 1 item -->
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>

</body>
</html>