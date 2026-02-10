<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bombay</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">
    <link rel="stylesheet" href="css/index.css"> <!-- Base Globale -->
    <link rel="stylesheet" href="css/header.css"> <!-- Header Standard -->
    <link rel="stylesheet" href="css/bombay.css"> <!-- Stile specifico Bombay -->
</head>
<body>

<%@ include file="header.jsp" %>

<div id="prima_sezione">
    <img src="img/Logo_Bombay.png"/>
</div>

<div class="seconda_sezione">
    
    <!-- Colonna immagine (Sinistra) -->
    <section class="img_sinistra">
        <img src="img/Bombay_foto.png" alt="Bombay Sapphire Foto">
    </section>

    <!-- Colonna testo (Destra) -->
    <section class="info_testo_dx">
        <div class="rettangolo_txt"> <!-- Corretto: era rettangolo_txt_dx nel tentativo precedente, ma il CSS dice rettangolo_txt -->
            <p>
                <strong>Bombay Sapphire</strong> è un London Dry Gin di fama mondiale, celebrato per il suo gusto equilibrato e versatile.
                La sua iconica bottiglia blu racchiude un distillato creato attraverso un processo unico di "Vapour Infusion",
                che cattura delicatamente gli aromi naturali delle botaniche.<br><br>
                Le 10 botaniche esotiche, tra cui ginepro toscano, scorza di limone spagnolo e coriandolo marocchino,
                vengono selezionate a mano da tutto il mondo. Il risultato è un gin dal profilo aromatico complesso ma morbido,
                perfetto per il classico Gin Tonic o per cocktail creativi.
            </p>
        </div>
    </section>

</div>

<div id = "terza_sezione">
    <section id="partner">
        <button class="bottone" type="button" onclick="window.location.href='bombay.jsp';">
            <div class ="rettangolo_bt">
                <img src="img/Bottiglia%20Gin%20Bombay.png" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='gin_mare.jsp';">
            <div class ="rettangolo_bt">
                <img src="img/Bottiglia%20Gin%20Mare.png" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='monkey_47.jsp';">
            <div class ="rettangolo_bt">
                <img src="img/Bottiglia%20Monkey%2047.png" class="bottiglie_gr"/>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='malfy.jsp';" >
            <div class="rettangolo_bt">
                <img src="img/Bottiglia%20Gin%20Malfy.png" class="bottiglie_gr"/>
            </div>
        </button>
    </section>
</div>

</body>
</html>
