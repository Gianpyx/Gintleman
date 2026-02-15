<%@ page import="java.sql.*" %>
<%@ page import="model.DriverManagerConnectionPool" %>
<%@ page contentType="text/plain" %>
<%
    try (Connection conn = DriverManagerConnectionPool.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT id, name FROM Product")) {
        while (rs.next()) {
            out.println(rs.getInt("id") + " : " + rs.getString("name"));
        }
    } catch (Exception e) {
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
