package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public synchronized UserBean doRetrieveByEmailPassword(String email, String password) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM User WHERE email = ? AND password = ?";

        UserBean bean = null;

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                bean = new UserBean();
                bean.setId(rs.getInt("id"));
                bean.setEmail(rs.getString("email"));
                bean.setPassword(rs.getString("password"));
                bean.setFirstName(rs.getString("first_name"));
                bean.setLastName(rs.getString("last_name"));
                bean.setRole(rs.getString("role"));
                bean.setCreatedAt(rs.getTimestamp("created_at"));
            }

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return bean;
    }

    public synchronized void doUpdate(UserBean user) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;

        String updateSQL = "UPDATE User SET first_name = ?, last_name = ?, password = ? WHERE id = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(updateSQL);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getId());

            ps.executeUpdate();
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public synchronized UserBean doRetrieveByKey(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        UserBean bean = null;

        String selectSQL = "SELECT * FROM User WHERE id = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(selectSQL);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                bean = new UserBean();
                bean.setId(rs.getInt("id"));
                bean.setEmail(rs.getString("email"));
                bean.setPassword(rs.getString("password"));
                bean.setFirstName(rs.getString("first_name"));
                bean.setLastName(rs.getString("last_name"));
                bean.setRole(rs.getString("role"));
                bean.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return bean;
    }
}
