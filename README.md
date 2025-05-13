# Mobile Sales Mini App

## Overview

Mobile Sales Mini is a Flutter-based offline-first sales automation app using:

- **Hive** for local storage.
- **Riverpod** for state management.
- **GoRouter** for modern routing.
- Custom UI components (drawer, badges, etc.).
- Local role and permission checks.

The app is designed for scenarios where **APIs are not available**, and all data is stored and managed locally.

---

## Technologies Used

| Technology | Description                                                      |
| ---------- | ---------------------------------------------------------------- |
| Flutter    | Frontend UI                                                      |
| Riverpod   | State Management (`StateNotifier`)                               |
| Hive       | Local storage with boxes (`usersBox`, `salesBox`, `settingsBox`) |
| GoRouter   | Routing & navigation (`/inventory/detail/:productId`)            |
| Custom UI  | Drawer, PullRefreshList, NotificationBadgeIcon                   |

---

## Core Features

- **Login & Session Management** (local only).
- **Role and Permission Management** (per user).
- **Session Timer (15 mins inactivity auto-logout).**
- **Offline Inventory, Sales Orders, and Customer Management.**
- **Pull to refresh lists (`LPullRefreshList`).**
- **Dynamic Order Number Generator.**
- **Notifications Center with Badge system.**
- **Theme Toggle and App Drawer Navigation.**
- **Order Detail, Receipt Preview, and Timeline View.**

---

## Default Credentials (Development Mode)

| Username | Password |
| -------- | -------- |
| admin    | admin123 |

> ⚠ Ensure your `usersBox` is seeded correctly using `seedTestUser()` on app startup.

---

## Permissions Used in the App
