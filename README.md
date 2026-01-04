# 🛒 ShopStack Pro - Full-Stack E-commerce Ecosystem

[![CI/CD Pipeline](https://github.com/dhiraj143/fullstack-ecom/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/dhiraj143/fullstack-ecom/actions)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.2-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![React](https://img.shields.io/badge/React-18-blue.svg)](https://reactjs.org/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)

**ShopStack Pro** is a modern, enterprise-grade e-commerce platform designed for scalability and performance. It features a robust Spring Boot backend and a sleek, responsive React frontend.

---

## ✨ Key Features

- **🔐 Advanced Security**: Secure JWT-based authentication with **Forgot Password** (Email reset) and Multi-Role Access Control (Admin, Seller, User).
- **💳 Seamless Payments**: Integrated with **Stripe** for secure, real-time transaction processing.
- **🚀 High Performance**: **Redis Caching** implemented for product listings and categories to ensure lightning-fast response times.
- **☁️ Cloud-Native**: Automated image management via **Cloudinary**.
- **📊 Admin Dashboard**: Comprehensive management suite for products, orders, and user analytics.
- **🛠️ DevOps Ready**: Fully containerized with **Docker & Docker Compose**.
- **🤖 Automated CI/CD**: Continuous Integration and Deployment via **GitHub Actions** with automated testing and smoke tests.
- **🧪 Quality Assured**: Extensive unit testing using **JUnit 5** and **Mockito**.

---

## 🛠️ Tech Stack

### Backend (The Engine)
- **Java 17** & **Spring Boot 3.2**
- **Spring Security** (JWT, OAuth2 ready)
- **Spring Data JPA** (MySQL)
- **Redis** (Caching & Session management)
- **Spring Boot Actuator** (Monitoring & Health checks)
- **Thymeleaf** (Email templates)
- **Maven** (Build tool)

### Frontend (The Interface)
- **React 18** (Vite)
- **Tailwind CSS** (Premium UI/UX)
- **Lucide Icons** & **Framer Motion** (Animations)
- **Axios** (API communication)

---

## 🚀 Quick Start (Docker)

The easiest way to get started is using Docker Compose:

```bash
# Clone the repository
https://github.com/Dhiraj706Sardar/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem.git

# Start the entire stack
docker compose up --build
```

The application will be available at:
- **Frontend**: `http://localhost:3000`
- **Backend API**: `http://localhost:8080`
- **Actuator Health**: `http://localhost:8080/actuator/health`

---

## 🧪 Testing

Run the automated test suite:

```bash
cd backend
mvn test
```

---

## 📦 CI/CD Pipeline

The project includes a `.github/workflows/ci-cd.yml` that:
1. **Builds & Tests** the Java backend.
2. **Builds & Validates** the React frontend.
3. **Smoke Tests** the entire stack using Docker Compose.
4. **Pushes** production-ready images to Docker Hub (`dhiraj143/ecommerce-backend`).

---

## 📄 License
This project is licensed under the MIT License.
