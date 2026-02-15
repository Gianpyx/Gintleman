import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class GetProducts {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/gintleman_db";
        String user = "root";
        String password = "admin123";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, password);
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(
                            "SELECT id, name, subtitle FROM Product WHERE name LIKE '%Malfy%' OR name LIKE '%Bombay%' OR name LIKE '%Mare%' OR name LIKE '%Monkey%'")) {

                while (rs.next()) {
                    System.out
                            .println(rs.getInt("id") + " : " + rs.getString("name") + " - " + rs.getString("subtitle"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
