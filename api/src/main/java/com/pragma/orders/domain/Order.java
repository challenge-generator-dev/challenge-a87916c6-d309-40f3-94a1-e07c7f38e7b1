package com.pragma.orders.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    private String id;
    
    @NotNull(message = "El cliente es obligatorio")
    @Size(min = 1, max = 50, message = "El ID del cliente debe tener entre 1 y 50 caracteres")
    private String customerId;
    
    @NotNull(message = "Los ítems de la orden no pueden ser nulos")
    private List<OrderItem> items;
    
    @NotNull(message = "El estado de la orden es obligatorio")
    private OrderStatus status;
    
    @Positive(message = "El total debe ser un valor positivo")
    private double totalAmount;
    
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public enum OrderStatus {
        CREATED,
        PROCESSING,
        COMPLETED,
        CANCELLED
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class OrderItem {
        @NotNull(message = "El ID del producto es obligatorio")
        private String productId;
        
        @Positive(message = "La cantidad debe ser positiva")
        private int quantity;
        
        @Positive(message = "El precio debe ser positivo")
        private double price;
    }
}