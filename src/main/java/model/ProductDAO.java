package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDAO {

    /**
     * Retrieves all active products, optionally filtered by min/max price and
     * nationality.
     */
    public synchronized List<ProductBean> doRetrieveAll(Double minPrice, Double maxPrice, List<String> nationalities)
            throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<ProductBean> products = new ArrayList<>();

        StringBuilder query = new StringBuilder("SELECT * FROM Product WHERE is_active = TRUE");

        if (minPrice != null) {
            query.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            query.append(" AND price <= ?");
        }
        if (nationalities != null && !nationalities.isEmpty()) {
            query.append(" AND nationality IN (");
            for (int i = 0; i < nationalities.size(); i++) {
                query.append("?");
                if (i < nationalities.size() - 1) {
                    query.append(",");
                }
            }
            query.append(")");
        }

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(query.toString());

            int paramIndex = 1;
            if (minPrice != null)
                preparedStatement.setDouble(paramIndex++, minPrice);
            if (maxPrice != null)
                preparedStatement.setDouble(paramIndex++, maxPrice);

            if (nationalities != null && !nationalities.isEmpty()) {
                for (String nat : nationalities) {
                    preparedStatement.setString(paramIndex++, nat);
                }
            }

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                ProductBean bean = new ProductBean();
                bean.setId(rs.getInt("id"));
                bean.setName(rs.getString("name"));
                bean.setDescription(rs.getString("description"));
                bean.setPrice(rs.getBigDecimal("price"));
                bean.setStock(rs.getInt("stock"));
                bean.setImageUrl(rs.getString("image_url"));
                bean.setCategory(rs.getString("category"));
                bean.setAlcoholContent(rs.getBigDecimal("alcohol_content"));
                bean.setNationality(rs.getString("nationality"));
                bean.setSubtitle(rs.getString("subtitle"));
                bean.setActive(rs.getBoolean("is_active"));
                products.add(bean);
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
        return products;
    }

    public synchronized ProductBean doRetrieveByKey(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ProductBean bean = null;

        String selectSQL = "SELECT * FROM Product WHERE id = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                bean = new ProductBean();
                bean.setId(rs.getInt("id"));
                bean.setName(rs.getString("name"));
                bean.setDescription(rs.getString("description"));
                bean.setPrice(rs.getBigDecimal("price"));
                bean.setStock(rs.getInt("stock"));
                bean.setImageUrl(rs.getString("image_url"));
                bean.setCategory(rs.getString("category"));
                bean.setAlcoholContent(rs.getBigDecimal("alcohol_content"));
                bean.setNationality(rs.getString("nationality"));
                bean.setSubtitle(rs.getString("subtitle"));
                bean.setActive(rs.getBoolean("is_active"));
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

    public synchronized void doSave(ProductBean product) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO Product (name, description, price, stock, image_url, category, alcohol_content, nationality, subtitle, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setBigDecimal(3, product.getPrice());
            preparedStatement.setInt(4, product.getStock());
            preparedStatement.setString(5, product.getImageUrl());
            preparedStatement.setString(6, product.getCategory());
            preparedStatement.setBigDecimal(7, product.getAlcoholContent());
            preparedStatement.setString(8, product.getNationality());
            preparedStatement.setString(9, product.getSubtitle());
            preparedStatement.setBoolean(10, product.isActive());

            preparedStatement.executeUpdate();

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public synchronized void doUpdate(ProductBean product) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE Product SET name = ?, description = ?, price = ?, stock = ?, image_url = ?, category = ?, alcohol_content = ?, nationality = ?, subtitle = ?, is_active = ? WHERE id = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setBigDecimal(3, product.getPrice());
            preparedStatement.setInt(4, product.getStock());
            preparedStatement.setString(5, product.getImageUrl());
            preparedStatement.setString(6, product.getCategory());
            preparedStatement.setBigDecimal(7, product.getAlcoholContent());
            preparedStatement.setString(8, product.getNationality());
            preparedStatement.setString(9, product.getSubtitle());
            preparedStatement.setBoolean(10, product.isActive());
            preparedStatement.setInt(11, product.getId());

            preparedStatement.executeUpdate();

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public synchronized void doDelete(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String deleteSQL = "UPDATE Product SET is_active = FALSE WHERE id = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(deleteSQL);
            preparedStatement.setInt(1, id);

            preparedStatement.executeUpdate();

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public synchronized void checkStockBulk(Cart cart) throws SQLException, OutOfStockException {
        Connection connection = null;
        PreparedStatement ps = null;
        Map<String, Integer> unavailable = new HashMap<>();

        String sql = "SELECT name, stock FROM Product WHERE id = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(sql);

            for (CartItem item : cart.getItems()) {
                ps.setInt(1, item.getProduct().getId());
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int currentStock = rs.getInt("stock");
                        if (currentStock < item.getQuantity()) {
                            unavailable.put(rs.getString("name"), currentStock);
                        }
                    }
                }
            }

            if (!unavailable.isEmpty()) {
                throw new OutOfStockException(unavailable);
            }
        } finally {
            if (ps != null)
                ps.close();
            if (connection != null)
                connection.close();
        }
    }

    public synchronized void decrementStock(int productId, int quantity, Connection connection)
            throws SQLException, OutOfStockException {
        PreparedStatement ps = null;
        String sql = "UPDATE Product SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                // This shouldn't happen if checkStockBulk was called, but for safety:
                String checkSql = "SELECT name, stock FROM Product WHERE id = ?";
                try (PreparedStatement psCheck = connection.prepareStatement(checkSql)) {
                    psCheck.setInt(1, productId);
                    try (ResultSet rs = psCheck.executeQuery()) {
                        if (rs.next()) {
                            Map<String, Integer> single = new HashMap<>();
                            single.put(rs.getString("name"), rs.getInt("stock"));
                            throw new OutOfStockException(single);
                        } else {
                            throw new SQLException("Product not found: " + productId);
                        }
                    }
                }
            }
        } finally {
            if (ps != null)
                ps.close();
        }
    }

    public synchronized void zeroStock(int productId) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        String sql = "UPDATE Product SET stock = 0 WHERE id = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
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
}
