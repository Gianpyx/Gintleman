<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="css/registration.css">
</head>

<body>
<main class="registration">
    <!-- Colonna sinistra -->
    <div class="registration_sx">
        <img src="img/bottiglia_registrazione.png" alt="Decorazione login" />
    </div>

    <!-- Colonna destra-->
    <div class="registration_rx">
        <div class="registration_in">
            <h1 class="registration_title">Create an account</h1>
            <p class="registration_sub_title">already registered? press <a class="scritta_in_blu" href="login.jsp">here</a></p>

            <form action="registration" method="post" class="registration_form" autocomplete="on">
                <div class="registration_row">
                    <label for="name" class="visually-hidden">First Name</label>
                    <input id="name" name="name" type="text" placeholder="First name" required class="registration_input">

                    <label for="last_name" class="visually-hidden">Last Name</label>
                    <input id="last_name" name="last_name" type="text" placeholder="Last name" required class="registration_input">
                </div>

                <label for="email" class="visually-hidden">e-mail</label>
                <input id="email" name="email" type="email" placeholder="e-mail" required class="registration_input">

                <label for="password" class="visually-hidden">password</label>
                <input id="password" name="password" type="password" placeholder="password" required class="registration_input">

                <button class="registration_submit" type="submit">Register</button>
            </form>
        </div>
    </div>


</main>
</body>
</html>
