<%--
  Created by IntelliJ IDEA.
  User: gianpy
  Date: 16/09/25
  Time: 00:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gin Mare</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">

    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/gin_mare.css"> <!-- Stili dell'homepage -->
</head>
<body>

<%@ include file="header.jsp" %>

<div id="prima_sezione">
        <img src="img/Gin_mare_logo.png"/>
</div>



<div class="seconda_sezione">

    <!-- Colonna testo -->
    <section class="info_testo_sx">
        <div class="rettangolo_txt">
            <p>
                Gin Mare è un gin ultra-premium nato sulla costa spagnola. Lontano dai classici schemi del London Dry,
                Gin Mare celebra i profumi e i sapori tipici del Mediterraneo con una selezione unica di botaniche:
                basilico italiano, rosmarino greco, timo turco e olive Arbequina spagnole.

                Il suo profilo aromatico è raffinato, fresco ed erbaceo, con una nota salina distintiva che
                lo rende perfetto per cocktail sofisticati o da gustare liscio con ghiaccio.
            </p>
        </div>
    </section>

    <!-- Colonna immagine -->
    <section class="img_destra">
        <img src="img/Gin_mare_foto.png">
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
    </section>
</div>
</body>
</html>
