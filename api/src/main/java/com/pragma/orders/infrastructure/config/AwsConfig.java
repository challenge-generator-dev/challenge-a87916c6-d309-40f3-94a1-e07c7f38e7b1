package com.pragma.orders.infrastructure.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbAsyncClient;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.sqs.SqsClient;

import java.net.URI;

@Configuration
public class AwsConfig {

    @Value("${AWS_ACCESS_KEY_ID:#{systemEnvironment['AWS_ACCESS_KEY_ID']}}")
    private String accessKeyId;

    @Value("${AWS_SECRET_ACCESS_KEY:#{systemEnvironment['AWS_SECRET_ACCESS_KEY']}}")
    private String secretAccessKey;

    @Value("${AWS_REGION:us-east-1}")
    private String region;

    @Value("${AWS_DYNAMODB_ENDPOINT:#{systemEnvironment['AWS_DYNAMODB_ENDPOINT']}}")
    private String dynamoDbEndpoint;

    @Value("${AWS_SQS_ENDPOINT:#{systemEnvironment['AWS_SQS_ENDPOINT']}}")
    private String sqsEndpoint;

    @Value("${AWS_LAMBDA_ENDPOINT:#{systemEnvironment['AWS_LAMBDA_ENDPOINT']}}")
    private String lambdaEndpoint;

    @Bean
    public AwsBasicCredentials awsBasicCredentials() {
        if (accessKeyId == null || secretAccessKey == null || accessKeyId.isEmpty() || secretAccessKey.isEmpty()) {
            throw new IllegalStateException(
                "AWS credentials not configured. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables."
            );
        }
        return AwsBasicCredentials.create(accessKeyId, secretAccessKey);
    }

    @Bean
    public Region awsRegion() {
        return Region.of(region);
    }

    @Bean
    public StaticCredentialsProvider staticCredentialsProvider(AwsBasicCredentials awsBasicCredentials) {
        return StaticCredentialsProvider.create(awsBasicCredentials);
    }

    @Bean
    public DynamoDbClient dynamoDbClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = DynamoDbClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (dynamoDbEndpoint != null && !dynamoDbEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(dynamoDbEndpoint));
        }

        return builder.build();
    }

    @Bean
    public DynamoDbAsyncClient dynamoDbAsyncClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = DynamoDbAsyncClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (dynamoDbEndpoint != null && !dynamoDbEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(dynamoDbEndpoint));
        }

        return builder.build();
    }

    @Bean
    public SqsClient sqsClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = SqsClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (sqsEndpoint != null && !sqsEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(sqsEndpoint));
        }

        return builder.build();
    }

    @Bean
    public LambdaClient lambdaClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = LambdaClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (lambdaEndpoint != null && !lambdaEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(lambdaEndpoint));
        }

        return builder.build();
    }
}