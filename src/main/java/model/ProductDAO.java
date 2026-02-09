package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /**
     * Retrieves all active products, optionally filtered by min/max price and
     * nationality.
     */
    public synchronized List<ProductBean> doRetrieveAll(Double minPrice, Double maxPrice, String nationality)
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
        if (nationality != null && !nationality.isEmpty()) {
            query.append(" AND nationality = ?");
        }

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(query.toString());

            int paramIndex = 1;
            if (minPrice != null)
                preparedStatement.setDouble(paramIndex++, minPrice);
            if (maxPrice != null)
                preparedStatement.setDouble(paramIndex++, maxPrice);
            if (nationality != null && !nationality.isEmpty())
                preparedStatement.setString(paramIndex++, nationality);

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

        String insertSQL = "INSERT INTO Product (name, description, price, stock, image_url, category, alcohol_content, nationality, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            preparedStatement.setBoolean(9, product.isActive());

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

        String updateSQL = "UPDATE Product SET name = ?, description = ?, price = ?, stock = ?, image_url = ?, category = ?, alcohol_content = ?, nationality = ?, is_active = ? WHERE id = ?";

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
            preparedStatement.setBoolean(9, product.isActive());
            preparedStatement.setInt(10, product.getId());

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
}
