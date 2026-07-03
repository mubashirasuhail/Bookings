# Bookings App (Development Task)

A clean, responsive, and production-ready Flutter mobile application built for the GoParty recruitment evaluation task. The application implements an advanced order management dashboard featuring tab filters, real-time query searching, and expandable/collapsible booking cards, matching the provided design specifications.

---

## 🛠️ Architecture & State Management

This project is structured using the **MVC (Model-View-Controller)** architectural pattern combined with the **Provider** package for robust, state-driven user interface management. This ensures a clean separation of concerns, keeping business rules independent of layout configurations.

* **Model (`lib/models/`):** Contains strongly typed data representations and structural blueprints. It includes built-in factory conversion mapping explicitly designed to safely handle JSON payloads coming from Cloud Firestore.
* **Controller (`lib/controllers/`):** Implemented via `OrderController` (extending `ChangeNotifier`). It handles all intent operations, manages state transitions (tracking the active filter tabs, evaluation queries, and card expand/collapse triggers), and serves as the functional bridge between data and presentation.
* **View (`lib/views/`):** Decoupled, modular UI components and screens that capture user interactions and dispatch them to the Controller, utilizing a centralized design framework (`AppColors`) to maintain visual consistency.

---

## ☁️ Firebase Connection & Data Schema Blueprint

Due to a personal Firebase console billing constraint, a live database instance could not be initialized for this submission. However, **the application’s data layer has been fully architected, engineered, and prepped for immediate Firebase integration.**

The data structures are built to directly consume a Firestore collection named `orders`. 

### Expected Firestore Document Schema
Each document inside the `orders` collection should follow this format:

```json
{
  "title": "Corporate Summit Package",
  "vendor": "EliteVenues Dubai",
  "status": "pending", 
  "rating": 4.9,
  "total": "AED 4,200",
  "orderDate": "28 Jun 2025",
  "eventDate": "5 Jul 2025",
  "guests": "80 people",
  "addon": "Candy Station",
  "imagepath": "assets/images/summit.jpg"
}
