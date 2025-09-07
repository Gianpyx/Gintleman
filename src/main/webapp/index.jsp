<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang = "it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gintleman</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">

    <link rel="stylesheet" href="css/style.css"> <!-- Stili dell'homepage -->
    <link rel="stylesheet" href="css/style_tablet.css"> <!-- Stili dell'homepage -->
    <link rel="stylesheet" href="css/style_mobile.css"> <!-- Stili dell'homepage -->
    <link rel="stylesheet" href="css/header.css"> <!-- Stili dell’header -->
    <link rel="stylesheet" href="css/footer.css"> <!-- Stili del footer -->
    <link rel="stylesheet" href="font/stylesheet1.css"> <!-- Font -->

</head>

<body>


<%@ include file="header.jsp" %>




<div id = "hero">
    <section id = "zona_centrale">
        <h1 id="Title">Gintleman</h1>
        <p>Il tuo gin con un click</p>
        <button class="scopri_di_piu" type="button">
            <span class="sdp_text">Scopri di più</span>
            <span class="sdp_arrow">↓</span>
        </button>
    </section>
</div>





<div id = "second_section">
    <h1 id="title_2">
        Our Partnership
    </h1>
    <section id="partner">
        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <img src="img/Bottiglia%20Gin%20Bombay.png" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <img src="img/Bottiglia%20Gin%20Mare.png" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <img src="img/Bottiglia%20Monkey%2047.png" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';" >
            <div class="rettangolo_bt">
                <img src="img/Bottiglia%20Gin%20Malfy.png" class="bottiglie_gr"/>
            </div>
        </button>
    </section>
</div>




<div id="third_section">
    <section id="general">
        <button id="scopri_di_più">
            <div id="rettangolo_sdp">
                
            </div>
        </button>

        <button id="go_shopping">
            <div id="rettangolo_gs">
                <div id="testo_cerchio">
                    <p id="go_shopping_txt">Go shopping</p>
                </div>
            </div>
            </button>
    </section>
</div>


<div id = "fouth_section">
    <h1 id = "title_3">
        Best Seller
    </h1>
    <section id="best_seller">
        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <img src="" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <img src="" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <img src="" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';" >
            <div class="rettangolo_bt">
                <img src="" class="bottiglie_gr"/>
            </div>
        </button>
    </section>
</div>



<div id = "fifth_section">
    <div id = "riquadri_shop">
        <button class="bottone_piccolo" type="button" onclick="window.location.href='login.jsp';">
            <div class="bt_piccolo">
                <img src="img/Costiera%20Amalfitana.png" class="bt_piccolo_gr"/>
                <p class="caption">Gin Italiani</p>
            </div>
        </button>
        <button class="bottone_piccolo" type="button" onclick="window.location.href='login.jsp';">
            <div class="bt_piccolo">
                <p class="caption">Gin Esteri</p>
                <img src="img/Londra.png" class="bt_piccolo_gr"/>
            </div>
        </button>
        <div id="cta_section">
            <div class="cta_card">
                <p class="cta_title">Registrati su Gintleman<br>e scopri i tuoi vantaggi.</p>
                <button type="button" class="cta_btn" onclick="window.location.href='login.jsp';">
                    Scopri tutti i vantaggi
                </button>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
<script src="js/header.js"></script>


</body>
</html>