package model;

import java.io.Serializable;
import java.math.BigDecimal;

// Rappresenta una singola riga (prodotto + quantità) all'interno del carrello
public class CartItem implements Serializable {
    private ProductBean product;
    private int quantity;

    public CartItem(ProductBean product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public ProductBean getProduct() {
        return product;
    }

    public void setProduct(ProductBean product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void incrementQuantity() {
        this.quantity++;
    }

    public void decrementQuantity() {
        if (this.quantity > 0) {
            this.quantity--;
        }
    }

    // Calcola il prezzo totale per questa riga (Prezzo Unitario * Quantità)
    public BigDecimal getTotalPrice() {
        return product.getPrice().multiply(new BigDecimal(quantity));
    }
}
