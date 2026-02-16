package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Gestisce la connessione al database MySQL
public class DriverManagerConnectionPool {

    private static String DRIVER_CLASS_NAME = "com.mysql.cj.jdbc.Driver";
    private static String DB_URL = "jdbc:mysql://localhost:3306/gintleman_db";
    private static String USER = "root";
    private static String PASSWORD = "admin123";

    // Caricamento statico del driver JDBC all'avvio dell'applicazione
    static {
        try {
            Class.forName(DRIVER_CLASS_NAME);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Driver MySQL cannot be found", e);
        }
    }

    // Restituisce una nuova connessione attiva al database
    public static Connection getConnection() throws SQLException {
        try {
            System.out.println("DEBUG: Tentativo connessione DB...");
            System.out.println("DEBUG: URL=" + DB_URL);
            System.out.println("DEBUG: USER=" + USER);
            // Non stampiamo la password per sicurezza, ma sappiamo che è quella settata
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
            System.out.println("DEBUG: Connessione riuscita!");
            return conn;
        } catch (SQLException e) {
            System.err.println("DEBUG: ERRORE CONNESSIONE DB: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}
