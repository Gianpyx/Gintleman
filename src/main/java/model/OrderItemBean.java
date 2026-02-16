package model;

import java.io.Serializable;
import java.math.BigDecimal;

// Bean che rappresenta una singola riga di un ordine (prodotto acquistato, quantità e prezzo storico)
public class OrderItemBean implements Serializable {
    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal priceAtPurchase;

    // Opzionale: Dettagli completi del prodotto per la visualizzazione nello
    // storico
    private ProductBean product;

    public OrderItemBean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPriceAtPurchase() {
        return priceAtPurchase;
    }

    public void setPriceAtPurchase(BigDecimal priceAtPurchase) {
        this.priceAtPurchase = priceAtPurchase;
    }

    public ProductBean getProduct() {
        return product;
    }

    public void setProduct(ProductBean product) {
        this.product = product;
    }
}
