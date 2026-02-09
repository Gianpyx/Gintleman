package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class OrderBean implements Serializable {
    private int id;
    private int userId;
    private BigDecimal totalAmount;
    private String status; // PENDING, COMPLETED, CANCELED
    private Timestamp createdAt;
    private List<OrderItemBean> items; // Optional, for full order details

    public OrderBean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<OrderItemBean> getItems() {
        return items;
    }

    public void setItems(List<OrderItemBean> items) {
        this.items = items;
    }
}
