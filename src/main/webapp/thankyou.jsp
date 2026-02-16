<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Grazie - Gintleman</title>
    
    <!-- ==================== 
         STILI E RISORSE 
         ==================== -->
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="icon" sizes="16x16" href="img/Logo_nero.png" type="image/png">
    
    <!-- Stili inline per pagina di ringraziamento -->
    <style>
        .thankyou-container {
            max-width: 600px;
            margin: 150px auto 80px;
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .icon-check {
            width: 80px;
            height: 80px;
            background: #28a745;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 40px;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
        }
        p {
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        .btn-home {
            display: inline-block;
            background-color: #333;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.3s;
        }
        .btn-home:hover {
            background-color: #000;
        }
    </style>
</head>
<body>

<!-- Header Gintleman -->
<%@ include file="header.jsp" %>

<div class="thankyou-container">
    <div class="icon-check">✓</div>
    <h1>Grazie per il tuo ordine!</h1>
    <p>Il tuo ordine è stato completato con successo.<br>A breve riceverai una email di conferma.</p>
    
    <a href="index.jsp" class="btn-home">Torna alla Homepage</a>
</div>

</body>
</html>
