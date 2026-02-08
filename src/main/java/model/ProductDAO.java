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
}
