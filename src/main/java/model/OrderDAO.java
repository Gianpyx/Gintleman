package model;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /**
     * Saves an Order and its items in a transaction.
     * Captures current product prices for history (Req #20).
     */
    public synchronized int doSave(OrderBean order, Cart cart) throws SQLException {
        Connection connection = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        int orderId = -1;

        String insertOrderSQL = "INSERT INTO Orders (user_id, total_amount, status) VALUES (?, ?, ?)";
        String insertItemSQL = "INSERT INTO OrderItem (order_id, product_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            connection.setAutoCommit(false); // Start Transaction

            // 1. Insert Order
            psOrder = connection.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setBigDecimal(2, order.getTotalAmount());
            psOrder.setString(3, "COMPLETED"); // Assuming immediate completion for this MVP

            int affectedRows = psOrder.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
                    order.setId(orderId);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }

            // 2. Insert Order Items
            psItem = connection.prepareStatement(insertItemSQL);
            for (CartItem item : cart.getItems()) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getProduct().getId());
                psItem.setInt(3, item.getQuantity());
                // CRITICAL REQ #20: Save valid price at this moment
                psItem.setBigDecimal(4, item.getProduct().getPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();

            connection.commit(); // Commit Transaction

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            try {
                if (psItem != null)
                    psItem.close();
                if (psOrder != null)
                    psOrder.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return orderId;
    }

    public synchronized List<OrderBean> doRetrieveByUser(int userId) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        List<OrderBean> orders = new ArrayList<>();

        String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY created_at DESC";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderBean bean = new OrderBean();
                bean.setId(rs.getInt("id"));
                bean.setUserId(rs.getInt("user_id"));
                bean.setTotalAmount(rs.getBigDecimal("total_amount"));
                bean.setStatus(rs.getString("status"));
                bean.setCreatedAt(rs.getTimestamp("created_at"));
                orders.add(bean);
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
        return orders;
    }
}
