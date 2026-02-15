<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Malfy Gin</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">
    <link rel="stylesheet" href="css/index.css"> <!-- Base Globale -->
    <link rel="stylesheet" href="css/header.css"> <!-- Header Standard -->
    <link rel="stylesheet" href="css/footer.css"> <!-- Footer -->
    <link rel="stylesheet" href="css/malfy.css"> <!-- Stile specifico Malfy -->
    
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
        <h1 class="hero-title">Malfy Gin</h1>
        <h2 class="hero-subtitle">Gin Italiano</h2>
        
        <div class="hero-bottom-left">
            <p class="hero-description">L'autentico gin italiano ispirato alla Costiera Amalfitana.</p>
        </div>
    </div>
    
    <div class="hero-image-container">
        <img src="img/prodotto_malfy.png" alt="Malfy Gin Bottle" class="hero-bottle">
    </div>

    <div class="hero-cta-container">
        <a href="product?id=4" class="btn-buy">BUY 30.00€</a>
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
                    <span class="stat-value">ITALY</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">FOUNDING YEARS</span>
                    <span class="stat-value">2016</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">MAIN BOTANICALS</span>
                    <span class="stat-value">GINEPRO, LIMONI BIO DI SORRENTO</span>
                </div>
                <div class="stat-row no-border">
                    <span class="stat-label">MAIN BOTTLE</span>
                    <span class="stat-value">MALFY ORIGINALE</span>
                </div>
            </div>
            
            <div class="extra-stats-grid">
                <div class="stat-box">
                    <span class="box-number">950.000</span>
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

<!-- 3. PARTNER PRODUCT SECTION (Responsive Grid/Carousel) -->
<section class="partner-product-section">
    <div class="partner-container">
        <h2 class="section-title-white">Partner Product</h2>
        
        <div class="carousel-wrapper">
            <div class="carousel-track" id="malfyCarousel">
                <!-- Card 1 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_malfy.png" alt="Malfy Originale" class="partner-bottle-img">
                    </div>
                </div>
                
                <!-- Card 2 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_malfy_lemon.png" alt="Malfy Con Limone" class="partner-bottle-img">
                    </div>
                </div>
                
                <!-- Card 3 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_malfy_orange.png" alt="Malfy Con Arancia" class="partner-bottle-img">
                    </div>
                </div>
                
                <!-- Card 4 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_malfy_rosa.png" alt="Malfy Gin Rosa" class="partner-bottle-img">
                    </div>
                </div>
            </div>

            <!-- Navigation Arrow (Hidden on Desktop via CSS) -->
             <button class="nav-arrow-btn" id="carouselNext">&gt;</button>
        </div>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Carousel logic only needed if buttons are visible (Tablet/Mobile)
        // But we can leave it active, it won't hurt desktop if buttons are hidden.
        
        const carousel = document.getElementById('malfyCarousel');
        const nextBtn = document.getElementById('carouselNext');
        
        if (carousel && nextBtn) {
            let isAtEnd = false;

            nextBtn.addEventListener('click', function() {
                // If on desktop (button hidden), this won't trigger.
                // Mobile logic:
                const cardWidth = carousel.querySelector('.partner-card').offsetWidth;
                const gap = 32; // 2rem
                const scrollAmount = cardWidth + gap;

                if (!isAtEnd) {
                    carousel.scrollBy({ left: scrollAmount, behavior: 'smooth' });
                } else {
                    carousel.scrollTo({ left: 0, behavior: 'smooth' });
                    isAtEnd = false; 
                    nextBtn.classList.remove('rotated');
                }
            });

            // Detect scroll position to update arrow
            carousel.addEventListener('scroll', () => {
                const maxScrollLeft = carousel.scrollWidth - carousel.clientWidth;
                if (carousel.scrollLeft >= maxScrollLeft - 10) {
                    if (!isAtEnd) {
                        nextBtn.classList.add('rotated');
                        isAtEnd = true;
                    }
                } else {
                    if (isAtEnd && carousel.scrollLeft < maxScrollLeft - 10) {
                        nextBtn.classList.remove('rotated');
                        isAtEnd = false;
                    }
                }
            });
        }
    });
</script>

<%@ include file="footer.jsp" %>

</body>
</html>
