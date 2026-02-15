package model;

import java.util.Map;

public class OutOfStockException extends Exception {
    private Map<String, Integer> unavailableProducts;

    public OutOfStockException(Map<String, Integer> unavailableProducts) {
        super("Alcuni prodotti nel carrello non sono disponibili nelle quantità richieste.");
        this.unavailableProducts = unavailableProducts;
    }

    public Map<String, Integer> getUnavailableProducts() {
        return unavailableProducts;
    }
}
