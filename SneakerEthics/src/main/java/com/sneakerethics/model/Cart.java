package com.sneakerethics.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;
    private double total;

    public Cart() {
        this.items = new HashMap<>();
        this.total = 0.0;
    }

    public void addItem(Sneaker sneaker, int quantity) {
        if (items.containsKey(sneaker.getId())) {
            CartItem existingItem = items.get(sneaker.getId());
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            CartItem newItem = new CartItem(sneaker, quantity);
            items.put(sneaker.getId(), newItem);
        }
        calculateTotal();
    }

    public void removeItem(int sneakerId) {
        items.remove(sneakerId);
        calculateTotal();
    }

    public void updateQuantity(int sneakerId, int quantity) {
        if (items.containsKey(sneakerId)) {
            CartItem item = items.get(sneakerId);
            item.setQuantity(quantity);
            calculateTotal();
        }
    }

    public void clear() {
        items.clear();
        total = 0.0;
    }

    private void calculateTotal() {
        total = 0.0;
        for (CartItem item : items.values()) {
            total += item.getSubtotal();
        }
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public double getTotal() {
        return total;
    }

    public int getItemCount() {
        return items.size();
    }

    public static class CartItem {
        private Sneaker sneaker;
        private int quantity;

        public CartItem(Sneaker sneaker, int quantity) {
            this.sneaker = sneaker;
            this.quantity = quantity;
        }

        public Sneaker getSneaker() {
            return sneaker;
        }

        public void setSneaker(Sneaker sneaker) {
            this.sneaker = sneaker;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public double getSubtotal() {
            return sneaker.getPrice() * quantity;
        }
    }
} 