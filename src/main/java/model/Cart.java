package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

// Classe per la gestione del carrello della spesa virtuale
public class Cart implements Serializable {
    private List<CartItem> items;

    public Cart() {
        this.items = new ArrayList<>();
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void addItem(ProductBean product) {
        addItem(product, 1);
    }

    // Aggiunge un prodotto al carrello o ne incrementa la quantità se già presente
    public void addItem(ProductBean product, int quantity) {
        Optional<CartItem> existingItem = items.stream()
                .filter(i -> i.getProduct().getId() == product.getId())
                .findFirst();

        if (existingItem.isPresent()) {
            existingItem.get().setQuantity(existingItem.get().getQuantity() + quantity);
        } else {
            items.add(new CartItem(product, quantity));
        }
    }

    // Rimuove completamente un articolo dal carrello
    public void removeItem(int productId) {
        items.removeIf(i -> i.getProduct().getId() == productId);
    }

    // Aggiorna la quantità di uno specifico prodotto nel carrello
    public void updateQuantity(int productId, int quantity) {
        for (CartItem item : items) {
            if (item.getProduct().getId() == productId) {
                if (quantity <= 0) {
                    items.remove(item);
                } else {
                    item.setQuantity(quantity);
                }
                return;
            }
        }
    }

    // Calcola il prezzo totale di tutti gli articoli nel carrello
    public BigDecimal getTotalAmount() {
        return items.stream()
                .map(CartItem::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    // Restituisce il numero totale di pezzi presenti nel carrello
    public int getTotalItemsCount() {
        return items.stream().mapToInt(CartItem::getQuantity).sum();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
