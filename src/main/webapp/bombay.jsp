<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bombay</title>
    <link rel = "icon" sizes = "16x16" href = "img/Logo_nero.png" type = "image/png">
    <link rel="stylesheet" href="css/bombay.css"> <!-- Stili dell'homepage -->
</head>
<body>


<div id="prima_sezione">
    <img src="img/Logo_Bombay.png" alt=""/>
</div>


<div class="seconda_sezione">
            <!-- Colonna immagine -->
    <section class="img_sinistra">
        <img src="img/Bombay_foto.png" alt="">
    </section>
            <!-- Colonna testo -->
    <section class="info_testo_dx">
        <div class="rettangolo_txt">
            <p>
                Bombay Sapphire è un gin premium, noto per la sua raffinata qualità e il suo carattere distintivo.
                Distillato in Inghilterra, Bombay Sapphire è uno degli esemplari più iconici di gin London Dry,
                e la sua ricetta è un perfetto equilibrio di botaniche selezionate con cura,
                tra cui bacche di ginepro, mandorle, agrumi, radici di angelica e altro ancora.
                Bombay Sapphire è perfetto per preparare cocktail classici come il Gin Tonic, il Martini e il Negroni,
                ed è apprezzato da bartender e appassionati di gin per la sua versatilità e la sua qualità costante.
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


<div id = "quarta_sezione">
    <section id="partner_2">
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
    </section>
</div>

</body>
</html>
