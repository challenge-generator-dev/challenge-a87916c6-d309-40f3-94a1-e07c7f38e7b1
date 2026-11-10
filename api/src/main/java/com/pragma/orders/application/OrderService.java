package com.pragma.orders.application;

import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.domain.Order;
import com.pragma.orders.domain.Order.OrderItem;
import com.pragma.orders.domain.Order.OrderStatus;
import com.pragma.orders.domain.OrderRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public OrderResponseDTO createOrder(OrderRequestDTO request) {
        Order order = mapRequestToOrder(request);
        Order savedOrder = orderRepository.save(order);
        return mapOrderToResponse(savedOrder);
    }

    public Optional<OrderResponseDTO> getOrder(String id) {
        return orderRepository.findById(id)
                .map(this::mapOrderToResponse);
    }

    private Order mapRequestToOrder(OrderRequestDTO request) {
        String orderId = UUID.randomUUID().toString();
        LocalDateTime now = LocalDateTime.now();

        List<OrderItem> items = request.getItems().stream()
                .map(itemDTO -> new OrderItem(
                        itemDTO.getProductId(),
                        itemDTO.getQuantity(),
                        itemDTO.getUnitPrice()
                ))
                .collect(Collectors.toList());

        double totalAmount = items.stream()
                .mapToDouble(item -> item.getQuantity() * item.getPrice())
                .sum();

        Order order = new Order();
        order.setId(orderId);
        order.setCustomerId(request.getCustomerId());
        order.setItems(items);
        order.setStatus(OrderStatus.valueOf("PENDING"));
        order.setTotalAmount(totalAmount);
        order.setCreatedAt(now);
        order.setUpdatedAt(now);

        return order;
    }

    private OrderResponseDTO mapOrderToResponse(Order order) {
        List<OrderResponseDTO.OrderItemResponseDTO> itemResponses = order.getItems().stream()
                .map(item -> new OrderResponseDTO.OrderItemResponseDTO(
                        item.getProductId(),
                        item.getQuantity(),
                        item.getPrice(),
                        item.getQuantity() * item.getPrice()
                ))
                .collect(Collectors.toList());

        return new OrderResponseDTO(
                order.getId(),
                order.getCustomerId(),
                itemResponses,
                order.getStatus().name(),
                order.getTotalAmount(),
                order.getCreatedAt(),
                order.getUpdatedAt()
        );
    }
}