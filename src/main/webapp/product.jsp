<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bombay Sapphire - Gintleman</title> <!-- Placeholder title, dynamic in real app -->
    
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
            <h1 class="product-title-main">Bombay Sapphire</h1>
            <p class="product-subtitle-main">London dry gin</p>
        </div>

        <!-- Grid: 3 Columns -->
        <div class="product-grid">
            
            <!-- 1. Immagine (Box Blu) -->
            <div class="product-image-box">
                <!-- Immagine Placeholder: Assicurati che il percorso sia corretto -->
                <img src="img/Bottiglia%20Gin%20Bombay.png" alt="Bombay Sapphire">
            </div>

            <!-- 2. Descrizione -->
            <div class="product-description-box">
                <h2 class="desc-title">Descrizione</h2>
                <p class="desc-text">
                    Bombay Sapphire è un London Dry Gin molto conosciuto, spesso presente nei bar e nelle case grazie al suo gusto equilibrato e alla facile reperibilità. 
                    Distillato a vapore con 10 botaniche, tra cui ginepro, scorza di limone e coriandolo, offre un profilo fresco e leggermente speziato.
                    <br><br>
                    È una scelta affidabile e versatile, ideale per preparare cocktail classici come gin tonic e martini senza complicazioni.
                </p>
            </div>

            <!-- 3. Buy Box (Prezzo e CTA) -->
            <div class="product-buy-box">
                <p class="product-price">50€</p>
                
                <div>
                    <a href="#" class="shipping-badge">verifica la consegna gratuita</a>
                    <p class="shipping-info">consegna prevista entro <strong>5 giorni</strong> dall'acquisto</p>
                </div>

                <div class="availability-badge">
                    Disponibilità immediata
                </div>

                <!-- Select Quantità Custom -->
                <select class="qty-selector">
                    <option value="1">Quantità: 1</option>
                    <option value="2">Quantità: 2</option>
                    <option value="3">Quantità: 3</option>
                    <option value="4">Quantità: 4</option>
                    <option value="5">Quantità: 5</option>
                </select>

                <a href="#" class="btn-buy-outline">Acquista ora</a>
                <button class="btn-add-cart">Aggiungi al carrello</button>
            </div>

        </div>

    </main>

    <%@ include file="footer.jsp" %>

    <script src="js/index.js"></script> <!-- O script specifico se serve -->

</body>
</html>
