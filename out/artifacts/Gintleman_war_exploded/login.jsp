<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css">
</head>

<body>
<main class="login">
    <!-- Colonna sinistra -->
    <div class="login_sx">
        <div class="login_in">
            <h1 class="login_title">Sign In</h1>

            <form action="login" method="post" class="login_form" autocomplete="on">
                <label for="email" class="visually-hidden">e-mail</label>
                <input id="email" name="email" type="email" placeholder="e-mail" required class="login_input">

                <label for="password" class="visually-hidden">password</label>
                <input id="password" name="password" type="password" placeholder="password" required class="login_input">

                <button class="login_submit" type="submit">Sign In</button>

                <p class="login_hint">
                    if you’re not registered do it <a class="scritta_in_blu" href="registration.jsp">here</a>
                </p>
            </form>
        </div>
    </div>

    <!-- Colonna destra -->
    <div class="login_rx">
        <img src="img/bottiglia_login.png" alt="Decorazione login" />
    </div>
</main>
</body>
</html>
