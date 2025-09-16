<%--
  Created by IntelliJ IDEA.
  User: gianpy
  Date: 15/09/25
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Bombay</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">

    <link rel="stylesheet" href="css/malfy.css"> <!-- Stili dell'homepage -->

</head>
<body>




<div id="prima_sezione">
    <img src="img/malfy_logo.png"/>
</div>






<div class="seconda_sezione">
    <section class="info_testo_sx">
        <div class="rettangolo_txt_sx">
            <p>
                Gin Malfy è un’eccellenza italiana che racchiude la vivacità della Costiera Amalfitana in ogni bottiglia.
                Prodotto artigianalmente in Piemonte, questo gin premium nasce da una perfetta fusione tra tradizione e
                innovazione, utilizzando botaniche locali, agrumi italiani e l’acqua più pura delle Alpi.
            </p>
        </div>
    </section>

    <!-- Colonna immagine -->
    <section class="img_sinistra">
        <img src="img/malfy_bottiglia.png">
    </section>

    <!-- Colonna testo -->
    <section class="info_testo_dx">
        <div class="rettangolo_txt_dx">
            <p>
                Ogni variante della gamma Malfy è un viaggio sensoriale attraverso i profumi e i sapori del Bel Paese:
                dal pompelmo rosa di Sicilia al limone di Amalfi, passando per il ginepro raccolto a mano e infusi aromatici raffinati.
                Il design iconico delle bottiglie – colorato, fresco, solare –
                riflette l’anima mediterranea del brand, rendendolo subito riconoscibile e irresistibile.
            </p>
        </div>
    </section>
</div>





<div id = "terza_sezione">
    <section id="partner">
        <button class="bottone" type="button" onclick="window.location.href='bombay.jsp';">
            <div class ="rettangolo_bt">
                <%-- <img src="img/Bottiglia%20Gin%20Bombay.png" class="bottiglie_gr"/> --%>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <%-- <img src="img/Bottiglia%20Gin%20Mare.png" class="bottiglie_gr"/> --%>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';">
            <div class ="rettangolo_bt">
                <%-- <img src="img/Bottiglia%20Monkey%2047.png" class="bottiglie_gr"/> --%>
            </div>
        </button>

        <button class="bottone" type="button" onclick="window.location.href='login.jsp';" >
            <div class="rettangolo_bt">
                <%-- <img src="img/Bottiglia%20Gin%20Malfy.png" class="bottiglie_gr"/> --%>
            </div>
        </button>
    </section>
</div>

</body>
</html>
