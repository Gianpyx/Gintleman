<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bombay Sapphire</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">
    
    <!-- ==================== 
         STILI E RISORSE 
         ==================== -->
    <!-- Base Globale -->
    <link rel="stylesheet" href="css/index.css">
    <!-- Header Standard -->
    <link rel="stylesheet" href="css/header.css">
    <!-- Footer -->
    <link rel="stylesheet" href="css/footer.css">
    <!-- Stile Specifico Bombay -->
    <link rel="stylesheet" href="css/bombay.css">
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    
    <!-- Font Google: DM Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<!-- Header Gintleman -->
<%@ include file="header.jsp" %>

<!-- ==================== 
     1. SEZIONE HERO 
     ==================== -->
<section class="hero-section">
    <div class="hero-content">
        <h1 class="hero-title">Bombay Sapphire</h1>
        <h2 class="hero-subtitle">London dry gin</h2>
        
        <div class="hero-bottom-left">
            <p class="hero-description">Un classico London Dry Gin che si sposa volentieri con un gin tonic</p>
        </div>
    </div>
    
    <div class="hero-image-container">
        <!-- Usa l'immagine della bottiglia scontornata -->
        <img src="img/prodotto_bombay.png" alt="Bombay Sapphire Bottle" class="hero-bottle">
    </div>

    <div class="hero-cta-container">
        <!-- Link al prodotto specifico (ID=1 per Bombay) -->
        <a href="product?id=1" class="btn-buy">BUY 22.50€</a>
    </div>
</section>

<!-- ==================== 
     2. SEZIONE ABOUT 
     ==================== -->
<section class="about-section">
    <div class="about-container">
        <div class="about-left">
            <h2 class="about-title">About this partner</h2>
        </div>
        
        <div class="about-right">
            <div class="stats-table">
                <div class="stat-row">
                    <span class="stat-label">ORIGIN</span>
                    <span class="stat-value">ENGLAND</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">FOUNDING YEARS</span>
                    <span class="stat-value">1987</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">MAIN BOTANICALS</span>
                    <span class="stat-value">GINEPRO, LIMONE, CORIANDOLO</span>
                </div>
                <div class="stat-row no-border">
                    <span class="stat-label">MAIN BOTTLE</span>
                    <span class="stat-value">BOMBAY SAPPHIRE</span>
                </div>
            </div>
            
            <div class="extra-stats-grid">
                <div class="stat-box">
                    <span class="box-number">4.600.000</span>
                    <span class="box-label">casse vendute</span>
                </div>
                <div class="stat-box">
                    <span class="box-text">
                        <a href="https://www.bombaysapphire.com/it/it/" target="_blank" class="brand-link">Bombay Sapphire</a>
                    </span>
                    <span class="box-label">Original Site</span>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ==================== 
     3. SEZIONE PRODOTTI PARTNER 
     ==================== -->
<section class="partner-product-section">
    <div class="partner-container">
        <h2 class="section-title-white">Partner Product</h2>
        
        <div class="carousel-wrapper">
            <div class="carousel-track" id="bombayCarousel">
                <!-- Card 1 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_bombay_original.png" alt="Bombay Original" class="partner-bottle-img">
                    </div>
                </div>
                
                <!-- Card 2 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_bombay_premier_cru.png" alt="Bombay Premier Cru" class="partner-bottle-img">
                    </div>
                </div>
                
                <!-- Card 3 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_bombay_sunset.png" alt="Bombay Sunset" class="partner-bottle-img">
                    </div>
                </div>
                
                <!-- Card 4 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_bombay.png" alt="Bombay Sapphire" class="partner-bottle-img">
                    </div>
                </div>
                
                <!-- Card 5 -->
                <div class="partner-card">
                    <div class="card-inner">
                        <img src="img/prodotto_citron_presse.png" alt="Bombay Citron Presse" class="partner-bottle-img">
                    </div>
                </div>
            </div>

            <!-- Freccia di Navigazione -->
             <button class="nav-arrow-btn" id="carouselNext">&gt;</button>
        </div>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const carousel = document.getElementById('bombayCarousel');
        const nextBtn = document.getElementById('carouselNext');
        
        if (carousel && nextBtn) {
            let isAtEnd = false;

            nextBtn.addEventListener('click', function() {
                const cardWidth = carousel.querySelector('.partner-card').offsetWidth;
                const gap = 32; // 2rem
                const scrollAmount = cardWidth + gap;

                if (!isAtEnd) {
                    // Scroll a destra (elemento successivo)
                    carousel.scrollBy({ left: scrollAmount, behavior: 'smooth' });
                } else {
                    // Scroll all'inizio (sinistra)
                    carousel.scrollTo({ left: 0, behavior: 'smooth' });
                    isAtEnd = false; 
                    nextBtn.classList.remove('rotated');
                }
            });

            // Rileva posizione scroll per aggiornare la freccia
            carousel.addEventListener('scroll', () => {
                const maxScrollLeft = carousel.scrollWidth - carousel.clientWidth;
                // Se vicino alla fine (tolleranza 10px)
                if (carousel.scrollLeft >= maxScrollLeft - 10) {
                    if (!isAtEnd) {
                        nextBtn.classList.add('rotated');
                        isAtEnd = true;
                    }
                } else {
                    // Se l'utente torna indietro manualmente
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
