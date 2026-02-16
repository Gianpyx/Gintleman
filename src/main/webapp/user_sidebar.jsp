<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!-- ==================== 
     SIDEBAR UTENTE 
     ==================== -->
<aside class="admin-sidebar">
    <ul>
        <li>
            <a href="#" onclick="showSection('profile')" class="active" id="link-profile">
                Il Mio Profilo
            </a>
        </li>
        <li>
            <a href="#" onclick="showSection('orders')" id="link-orders">
                I Miei Ordini
            </a>
        </li>
        <li class="sidebar-divider"></li>
        <li>
            <a href="logout" class="logout-link">
                Esci
            </a>
        </li>
    </ul>
</aside>
