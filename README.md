# 🛒 ShopStack Pro - Full-Stack E-commerce Ecosystem

[![CI/CD Pipeline](https://github.com/Dhiraj706Sardar/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/Dhiraj706Sardar/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem/actions)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.2-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![React](https://img.shields.io/badge/React-18-blue.svg)](https://reactjs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**ShopStack Pro** is a modern, enterprise-grade e-commerce platform designed for high performance and scalability. It features a robust **Spring Boot 3.2** backend deployed on AWS with **Caddy** auto-HTTPS, **PostgreSQL 16**, and **Redis**, paired with a sleek, responsive **React 18** frontend hosted on **GitHub Pages**.

---

## 🌐 Live Deployments & Portals

| Portal | URL | Access / Role Required |
| :--- | :--- | :--- |
| 🛍️ **Storefront** | [Launch Storefront](https://dhiraj706sardar.github.io/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem/#/) | Public (Guests & Customers) |
| 💼 **Merchant Panel (Seller Hub)** | [Open Merchant Panel](https://dhiraj706sardar.github.io/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem/#/seller) | Requires `ROLE_SELLER` |
| 🛡️ **Admin Dashboard** | [Open Admin Dashboard](https://dhiraj706sardar.github.io/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem/#/admin) | Requires `ROLE_ADMIN` |
| 🔌 **Backend REST API** | [API Base Endpoint](https://shopstack-api.duckdns.org/api) | Public & Authenticated routes |
| 🩺 **Actuator Health** | [System Health Check](https://shopstack-api.duckdns.org/actuator/health) | Public health & readiness probes |

---

## 💼 Merchant Panel (Seller Hub)

The **Merchant Panel** (`/#/seller`) is a dedicated operational workspace for verified sellers to manage their business in real time:

- **📊 Sales & Revenue Analytics**: Interactive revenue graphs, daily order velocity, and earnings trends powered by Chart.js.
- **📦 Inventory & Product Catalog Management**: Create, edit, and delete products, manage stock quantities, set pricing, assign categories, and upload high-resolution product media directly to **Cloudinary**.
- **📑 Order Fulfillment**: Track customer orders, update delivery statuses (`PENDING`, `PROCESSING`, `SHIPPED`, `DELIVERED`, `CANCELLED`), and review order line items.
- **🔍 Catalog Search & Filters**: Quickly locate items by title, category, or stock status.

### How to Access the Merchant Panel:
1. Register an account at [Sign Up](https://dhiraj706sardar.github.io/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem/#/register).
2. Assign the `ROLE_SELLER` role to your user account in PostgreSQL:
   ```sql
   -- Connect to the database and grant the seller role
   INSERT INTO user_roles (user_id, role_id)
   SELECT u.id, r.id FROM users u, roles r
   WHERE u.email = 'your_seller_email@example.com' AND r.name = 'ROLE_SELLER';
   ```
3. Sign in at [Login](https://dhiraj706sardar.github.io/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem/#/login) — the **Seller Hub** link will appear in the navigation bar, or navigate directly to `/#/seller`.

---

## ✨ Key Features

- **🔐 Advanced Authentication & RBAC**: Secure JWT-based authentication with token refresh, password reset via Gmail SMTP, and Multi-Role Access Control (`ROLE_ADMIN`, `ROLE_SELLER`, `ROLE_USER`).
- **💳 Payment Processing**: Integrated with **Stripe** payment intents and real-time checkout verification.
- **🚀 In-Memory Caching**: **Redis** cache layer for high-throughput product listings and category queries.
- **☁️ Cloud Media Management**: Automated image uploads, optimization, and CDN delivery via **Cloudinary**.
- **📊 Multi-Tier Portals**: Separate dashboards for Customers, Merchants (Sellers), and System Administrators.
- **⚡ Dual Routing & Resilience**: Frontend uses React Router `HashRouter` for zero-configuration compatibility on static GitHub Pages hosting.
- **🤖 Automated CI/CD**: GitHub Actions workflow that builds, tests, containerizes, pushes images to Docker Hub, and deploys frontend builds to GitHub Pages on every release.

---

## 🛠️ Tech Stack

### Backend
- **Java 17** & **Spring Boot 3.2.2**
- **Spring Security** (Stateless JWT & Role-Based Authorization)
- **Spring Data JPA & Hibernate**
- **PostgreSQL 16** (Relational Database)
- **Redis** (High-speed caching)
- **Spring Boot Actuator** (Liveness, readiness, and service monitoring)
- **Stripe Java SDK** & **Cloudinary SDK**
- **Thymeleaf** (Transactional email templates)
- **Maven** (Dependency and build management)

### Frontend
- **React 18** & **Vite**
- **React Router v6** (`HashRouter` architecture)
- **Tailwind CSS** & **Radix UI** primitives
- **Lucide Icons** & **Framer Motion**
- **Chart.js** & **React-ChartJS-2** (Merchant analytics)
- **Axios** (Configured with automated token refresh interceptors)

### Infrastructure & DevOps
- **AWS EC2 (`t3.micro`)**: Hosts backend, PostgreSQL, Redis, and Caddy.
- **Caddy Web Server**: Reverse proxy with automated Let's Encrypt SSL/TLS certificates.
- **GitHub Pages**: Global CDN hosting for the static React client.
- **Docker & Docker Compose**: Multi-container containerization with memory-optimized JVM parameters.
- **GitHub Actions**: Continuous integration, Docker Hub publishing, and automated Pages deployment.

---

## 🚀 Quick Start (Local Development)

The easiest way to run the entire stack locally is with Docker Compose:

```bash
# 1. Clone the repository
git clone https://github.com/Dhiraj706Sardar/ShopStack-Pro---Full-Stack-E-commerce-Ecosystem.git
cd ShopStack-Pro---Full-Stack-E-commerce-Ecosystem

# 2. Configure environment variables
cp backend/.env.example backend/.env # Fill in your DB, JWT, and third-party keys

# 3. Start all services (Database, Redis, Backend, Frontend)
docker compose up --build
```

The services will be available at:
- **Frontend**: `http://localhost:3000`
- **Backend API**: `http://localhost:8081`
- **Actuator Health**: `http://localhost:8081/actuator/health`

---

## 🧪 Testing

Run the automated test suite with Maven:

```bash
cd backend
mvn test
```

---

## 📦 Production Deployment (AWS + GitHub Pages)

- **Frontend**: Automatically deployed to **GitHub Pages** via `.github/workflows/ci-cd.yml` on push to `main`.
- **Backend**: Runs on an AWS EC2 instance using `docker-compose.prod.yml`:
  ```bash
  cd ~/shopstack
  docker compose -f docker-compose.prod.yml pull
  docker compose -f docker-compose.prod.yml up -d
  ```

---

## 📄 License
This project is licensed under the [MIT License](LICENSE).
