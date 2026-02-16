package model;

import java.io.Serializable;
import java.math.BigDecimal;

// Bean che rappresenta un prodotto in vendita nel catalogo
public class ProductBean implements Serializable {
    private int id;
    private String name;
    private String description;
    private BigDecimal price; // BigDecimal per gestire correttamente la valuta
    private int stock;
    private String imageUrl;
    private String category;
    private BigDecimal alcoholContent;
    private String nationality;
    private String subtitle;
    private boolean isActive;

    public ProductBean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getAlcoholContent() {
        return alcoholContent;
    }

    public void setAlcoholContent(BigDecimal alcoholContent) {
        this.alcoholContent = alcoholContent;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
