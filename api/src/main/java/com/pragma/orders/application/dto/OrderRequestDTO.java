package com.pragma.orders.application.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Positive;
import java.util.List;

public class OrderRequestDTO {

    @NotBlank(message = "El ID del cliente es obligatorio")
    private String customerId;

    @NotEmpty(message = "La orden debe contener al menos un item")
    private List<OrderItemRequestDTO> items;

    public OrderRequestDTO() {}

    public OrderRequestDTO(String customerId, List<OrderItemRequestDTO> items) {
        this.customerId = customerId;
        this.items = items;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public List<OrderItemRequestDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemRequestDTO> items) {
        this.items = items;
    }

    public static class OrderItemRequestDTO {

        @NotBlank(message = "El ID del producto es obligatorio")
        private String productId;

        @Positive(message = "La cantidad debe ser mayor a cero")
        private int quantity;

        @Positive(message = "El precio unitario debe ser mayor a cero")
        private double unitPrice;

        public OrderItemRequestDTO() {}

        public OrderItemRequestDTO(String productId, int quantity, double unitPrice) {
            this.productId = productId;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
        }

        public String getProductId() {
            return productId;
        }

        public void setProductId(String productId) {
            this.productId = productId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public double getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(double unitPrice) {
            this.unitPrice = unitPrice;
        }
    }
}