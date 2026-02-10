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

      <!-- Sezione Centrale: Barra di Ricerca (Solo Desktop) -->
      <div class="sezione-centrale solo-desktop">
        <div class="barra-ricerca" onclick="this.querySelector('input').focus()">
          <form action="#" method="get">
            <button type="submit" aria-label="Cerca">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="11" cy="11" r="8"></circle>
                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
              </svg>
            </button>
            <label>
              <input type="text" name="cerca" placeholder="Cosa stai cercando?">
            </label>
          </form>
        </div>
      </div>

      <!-- Sezione Destra: Area Utente (Desktop) o Burger (Mobile) -->
      <div class="sezione-destra">
        <!-- Desktop: Login e Carrello -->
        <div class="area-utente solo-desktop">
          <div class="login">
            <%@ page import="model.UserBean" %>
            <%
              UserBean user = (UserBean) session.getAttribute("user");
              if (user != null) {
            %>
                <div class="user-icon" style="color: white; display: flex; align-items: center; gap: 10px;">
    <% if (user.isAdmin()) { %>
        <a href="admin_dashboard.jsp" class="login-scritta user-welcome-link">Welcome, <b><%= user.getFirstName() %></b></a>
    <% } else { %>
        <span class="login-scritta user-welcome-link">Welcome, <b><%= user.getFirstName() %></b></span>
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
        <!-- Ricerca Mobile -->
        <div class="ricerca-mobile">
           <form action="#" method="get">
             <label>
               <input type="text" name="cerca" placeholder="Cerca...">
             </label>
             <button type="submit">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="11" cy="11" r="8"></circle>
                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
              </svg>
            </button>
          </form>
        </div>
        <!-- Link Mobile -->
        <a href="login.jsp" class="link-mobile">Log in</a>
        <a href="#" class="link-mobile">Carrello</a>
      </div>
    </div>
  </header>
  </body>
</html>

