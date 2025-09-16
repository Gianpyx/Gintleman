<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Monkey 47</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">

    <link rel="stylesheet" href="css/monkey_47.css"> <!-- Stili dell'homepage -->
</head>
<body>




<div id="prima_sezione">
    <img src="img/monkey_logo.png"/>
</div>




<div class="sfondo_gradient">
<div class="seconda_sezione">
    <!-- Colonna immagine -->
    <section class="img_sinistra">
        <img src="img/monkey_bicchiere.png">
    </section>
    <!-- Colonna testo -->
    <section class="info_testo_dx">
        <div class="rettangolo_txt">
            <p>
                Monkey 47 nasce nella Foresta Nera tedesca e conquista con la sua complessità aromatica.
                Distillato con ben 47 botaniche selezionate da tutto il mondo — tra cui mirtilli rossi della Foresta Nera,
                erbe esotiche e spezie orientali — questo gin artigianale unisce
                la precisione tedesca con l’eccentricità britannica.
            </p>
        </div>
    </section>
    <section class="img_destra">
        <img src="img/monkey_bottiglia.png">
    </section>
</div>





<div id = "terza_sezione">
    <section id="partner">
        <button class="bottone" type="button" onclick="window.location.href='bombay.jsp';">
            <div class ="rettangolo_bt">
                <%-- <img src="img/Bottiglia%20Gin%20Bombay.png" class="bottiglie_gr"/> --%>
            </div>
        </button>
    </section>
</div>
</div>
</body>
</html>