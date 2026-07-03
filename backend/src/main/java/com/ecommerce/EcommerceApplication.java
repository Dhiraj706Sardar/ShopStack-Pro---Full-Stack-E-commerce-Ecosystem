package com.ecommerce;

import java.net.URI;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class EcommerceApplication {

    public static void main(String[] args) {
        configureRenderDatabaseUrl();
        SpringApplication.run(EcommerceApplication.class, args);
    }

    private static void configureRenderDatabaseUrl() {
        if (hasText(System.getenv("JDBC_DATABASE_URL")) || hasText(System.getenv("DB_URL"))) {
            return;
        }

        String databaseUrl = System.getenv("DATABASE_URL");
        if (!hasText(databaseUrl) || databaseUrl.startsWith("jdbc:")) {
            return;
        }

        URI uri = URI.create(databaseUrl);
        String scheme = uri.getScheme();
        if (!"postgres".equals(scheme) && !"postgresql".equals(scheme)) {
            return;
        }

        String jdbcUrl = "jdbc:postgresql://" + uri.getHost();
        if (uri.getPort() != -1) {
            jdbcUrl += ":" + uri.getPort();
        }
        jdbcUrl += uri.getPath();
        if (hasText(uri.getQuery())) {
            jdbcUrl += "?" + uri.getQuery();
        }

        System.setProperty("spring.datasource.url", jdbcUrl);

        String userInfo = uri.getUserInfo();
        if (hasText(userInfo)) {
            String[] credentials = userInfo.split(":", 2);
            if (credentials.length > 0 && hasText(credentials[0]) && !hasText(System.getenv("DB_USERNAME"))) {
                System.setProperty("spring.datasource.username", decode(credentials[0]));
            }
            if (credentials.length > 1 && hasText(credentials[1]) && !hasText(System.getenv("DB_PASSWORD"))) {
                System.setProperty("spring.datasource.password", decode(credentials[1]));
            }
        }
    }

    private static String decode(String value) {
        return URLDecoder.decode(value, StandardCharsets.UTF_8);
    }

    private static boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
