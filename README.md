# 🧾 NeoPOS – Flutter POS Management System

NeoPOS is a cross-platform Point of Sale (POS) application built using Flutter with Firebase Firestore as the backend and BLoC state management.
The system is designed for restaurants and retail environments, enabling efficient product, table, user, order, and sales management with real-time analytics.

## 🚀 Features

### 🔐 Authentication & Roles

- Admin and Waiter role-based access

- Secure credential verification for sensitive operations (delete/update)

- Role-based permissions enforced at UI & logic level

### 🧑‍💼 User Management

- Create, read, update, and delete users

- Username uniqueness validation

- Admin-only deletion and modification

- Desktop & mobile responsive UI

### 🍽 Product Management

- Create, update, delete products

- Product categories, pricing, availability

- Veg / Non-Veg classification

- Image upload with Firebase Storage

- Real-time product listing using Firestore
  
### 🪑 Table Management

- Create, update, delete tables

- Table capacity handling

- Live table tracking

- Admin credential validation for deletion

### 🛒 Order Management

- Add products to orders

- Quantity management

- Table-based ordering

- Order persistence in Firestore

### 📊 Sales Dashboard & Analytics

- Daily, Weekly, Monthly revenue calculation

- Interactive bar charts and pie charts

- Top 5 products (Daily / Weekly / Monthly)

- Recent transaction history

- Month-based sales filtering
  
### 🌐 Localization

- Multi-language support

- English & Hindi localization using .arb files

- Easily extendable to more languages

### 📱 Responsive Design

- Separate UI handling for:

- Desktop / Web

- Mobile devices

## 🏗 Architecture

The project follows Clean Architecture principles with BLoC (Business Logic Component) for state management.

Adaptive layouts and navigation

UI (Flutter Widgets)
        ↓
BLoC (Events & States)
        ↓
Repository / Service Layer
        ↓
Firebase Firestore

## 🔁 State Management

flutter_bloc

equatable for state comparison

Event-driven architecture

## 🔌 Dependency Injection

get_it used for Firebase Firestore singleton access

## 🛠 Tech Stack

| Technology           | Usage                   |
| -------------------- | ----------------------- |
| Flutter              | Cross-platform UI       |
| Dart                 | Programming Language    |
| Firebase Firestore   | Database                |
| Firebase Auth        | Authentication          |
| Firebase Storage     | Image storage           |
| BLoC                 | State management        |
| GetIt                | Dependency injection    |
| Syncfusion Charts    | Sales analytics         |
| Pie Chart            | Category-wise sales     |
| Cached Network Image | Optimized image loading |

## 📂 Project Structure
```text
lib/
 ├── di/                     # 🔌 Dependency Injection
 ├── l10n/                   # 🌐 Localization files
 ├── models/                 # 🧱 Data models
 ├── navigation/             # 🧭 App routing
 ├── screens/
 │    ├── products/          # 🍽 Product management
 │    ├── tables/            # 🪑 Table management
 │    ├── users/             # 👤 User management
 │    ├── orders/            # 🛒 Order handling
 │    ├── sales_dashboard/   # 📊 Sales & analytics
 │    └── login/             # 🔐 Authentication
 ├── utils/                  # 🛠 Validators & helpers
 └── main.dart               # 🚀 App entry point


 ## 🔥 Firebase Collections Used

  users

  products

  categories

  table

  live_table

  order_history
 






