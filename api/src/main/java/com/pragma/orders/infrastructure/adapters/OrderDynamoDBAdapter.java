package com.pragma.orders.infrastructure.adapters;

import com.pragma.orders.domain.Order;
import com.pragma.orders.domain.Order.OrderItem;
import com.pragma.orders.domain.Order.OrderStatus;
import com.pragma.orders.domain.OrderRepository;
import org.springframework.stereotype.Repository;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Repository
public class OrderDynamoDBAdapter implements OrderRepository {

    private static final String TABLE_NAME = "orders";
    private static final String ID_ATTRIBUTE = "id";
    private static final String CUSTOMER_ID_ATTRIBUTE = "customerId";
    private static final String ITEMS_ATTRIBUTE = "items";
    private static final String STATUS_ATTRIBUTE = "status";
    private static final String TOTAL_AMOUNT_ATTRIBUTE = "totalAmount";
    private static final String CREATED_AT_ATTRIBUTE = "createdAt";
    private static final String UPDATED_AT_ATTRIBUTE = "updatedAt";

    private final DynamoDbClient dynamoDbClient;

    public OrderDynamoDBAdapter(DynamoDbClient dynamoDbClient) {
        this.dynamoDbClient = dynamoDbClient;
    }

    @Override
    public Order save(Order order) {
        Map<String, AttributeValue> item = new HashMap<>();
        item.put(ID_ATTRIBUTE, AttributeValue.builder().s(order.getId()).build());
        item.put(CUSTOMER_ID_ATTRIBUTE, AttributeValue.builder().s(order.getCustomerId()).build());
        item.put(ITEMS_ATTRIBUTE, AttributeValue.builder().l(mapItemsToAttributeValue(order.getItems())).build());
        item.put(STATUS_ATTRIBUTE, AttributeValue.builder().s(order.getStatus().name()).build());
        item.put(TOTAL_AMOUNT_ATTRIBUTE, AttributeValue.builder().n(String.valueOf(order.getTotalAmount())).build());
        item.put(CREATED_AT_ATTRIBUTE, AttributeValue.builder().s(order.getCreatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)).build());
        item.put(UPDATED_AT_ATTRIBUTE, AttributeValue.builder().s(order.getUpdatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)).build());

        PutItemRequest request = PutItemRequest.builder()
                .tableName(TABLE_NAME)
                .item(item)
                .build();

        dynamoDbClient.putItem(request);
        return order;
    }

    @Override
    public Optional<Order> findById(String id) {
        GetItemRequest request = GetItemRequest.builder()
                .tableName(TABLE_NAME)
                .key(Map.of(ID_ATTRIBUTE, AttributeValue.builder().s(id).build()))
                .build();

        GetItemResponse response = dynamoDbClient.getItem(request);

        if (!response.hasItem() || response.item().isEmpty()) {
            return Optional.empty();
        }

        return Optional.of(mapAttributeValueToOrder(response.item()));
    }

    private List<AttributeValue> mapItemsToAttributeValue(List<OrderItem> items) {
        return items.stream()
                .map(item -> {
                    Map<String, AttributeValue> itemMap = new HashMap<>();
                    itemMap.put("productId", AttributeValue.builder().s(item.getProductId()).build());
                    itemMap.put("quantity", AttributeValue.builder().n(String.valueOf(item.getQuantity())).build());
                    itemMap.put("unitPrice", AttributeValue.builder().n(String.valueOf(item.getPrice())).build());
                    return AttributeValue.builder().m(itemMap).build();
                })
                .collect(Collectors.toList());
    }

    private Order mapAttributeValueToOrder(Map<String, AttributeValue> item) {
        Order order = new Order();
        order.setId(item.get(ID_ATTRIBUTE).s());
        order.setCustomerId(item.get(CUSTOMER_ID_ATTRIBUTE).s());
        order.setItems(mapAttributeValueToItems(item.get(ITEMS_ATTRIBUTE).l()));
        order.setStatus(OrderStatus.valueOf(item.get(STATUS_ATTRIBUTE).s()));
        order.setTotalAmount(Double.parseDouble(item.get(TOTAL_AMOUNT_ATTRIBUTE).n()));
        order.setCreatedAt(LocalDateTime.parse(item.get(CREATED_AT_ATTRIBUTE).s(), DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        order.setUpdatedAt(LocalDateTime.parse(item.get(UPDATED_AT_ATTRIBUTE).s(), DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        return order;
    }

    private List<OrderItem> mapAttributeValueToItems(List<AttributeValue> items) {
        return items.stream()
                .map(attr -> {
                    Map<String, AttributeValue> itemMap = attr.m();
                    return new OrderItem(
                            itemMap.get("productId").s(),
                            Integer.parseInt(itemMap.get("quantity").n()),
                            Double.parseDouble(itemMap.get("unitPrice").n())
                    );
                })
                .collect(Collectors.toList());
    }
}