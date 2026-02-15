<html>
  <head>
    <title>Header</title>
  </head>
  <body>
<header class="testata">
    <nav class="barra-navigazione">
      <!-- Sezione Sinistra: Logo -->
      <div class="sezione-sinistra">
        <button id="logo-header" type="button">
          <a href="index.jsp">
            <img src="img/Logo_2.png" sizes="32x32" alt="Home">
          </a>
        </button>
      </div>



      <!-- Sezione Destra: Area Utente (Desktop) o Burger (Mobile) -->
      <div class="sezione-destra">
        <!-- Desktop: Login e Carrello -->
        <div class="area-utente solo-desktop">
          <div class="login">
            <%@ page import="model.UserBean" %>
            <%
              UserBean headerUser = (UserBean) session.getAttribute("user");
              if (headerUser != null) {
            %>
                <div class="user-icon" style="color: white; display: flex; align-items: center; gap: 10px;">
    <% if (headerUser.isAdmin()) { %>
        <a href="admin_dashboard.jsp" class="login-scritta user-welcome-link">Welcome, <b><%= headerUser.getFirstName() %></b></a>
    <% } else { %>
        <a href="dashboard" class="login-scritta user-welcome-link">Welcome, <b><%= headerUser.getFirstName() %></b></a>
    <% } %>
                </div>
            <% } else { %>
                <a href="login.jsp" class="login-scritta">Log in</a>
            <% } %>
          </div>
          <div class="carrello">
            <a href="cart" id="bottone-carrello">
              <img src="img/Carrello_2.png" alt="Carrello"/>
            </a>
          </div>
        </div>

        <!-- Mobile: Burger Menu -->
        <button id="menu-hamburger" class="solo-mobile" aria-label="Menu">
          <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="3" y1="12" x2="21" y2="12"></line>
            <line x1="3" y1="6" x2="21" y2="6"></line>
            <line x1="3" y1="18" x2="21" y2="18"></line>
          </svg>
        </button>
      </div>
    </nav>

    <!-- Cassetto Navigazione Mobile -->
    <div id="cassetto-navigazione" class="cassetto-mobile solo-mobile">
      <div class="contenuto-cassetto">

        <!-- Link Mobile Login/User -->
        <% if (headerUser != null) { %>
            <% if (headerUser.isAdmin()) { %>
                <a href="admin_dashboard.jsp" class="link-mobile admin-disabled-mobile">Welcome, <b><%= headerUser.getFirstName() %></b></a>
            <% } else { %>
                <a href="dashboard" class="link-mobile">Welcome, <b><%= headerUser.getFirstName() %></b></a>
            <% } %>
        <% } else { %>
            <a href="login.jsp" class="link-mobile">Log in</a>
        <% } %>

        <!-- Link Mobile Carrello -->
        <a href="cart" class="link-mobile">Carrello</a>
      </div>
    </div>
  </header>
  <script src="js/header.js"></script>
  </body>
</html>

