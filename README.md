# 🥬 Smart Pantry

A Flutter-based mobile application designed to help you manage your pantry, track expiration dates, and effectively reduce food waste.

This project was developed as a personal challenge to build a fully functional application from scratch within a limited timeframe.

## 📸 Screenshots

<img width="1344" height="2992" alt="Screenshot_1761560360" src="https://github.com/user-attachments/assets/07b45f3d-0ec7-459d-b46f-f0104b8d6152" />

## ✨ Features

- **Full CRUD Functionality:** Easily **C**reate, **R**ead, **U**pdate, and **D**elete items in your pantry.
- **Persistent Storage:** Your data is saved locally on your device using an **SQFlite** database, so you never lose your list even when you close the app.
- **Smart Sorting:** Sort your pantry list to quickly see which items are expiring soonest, helping you prioritize what to use first.
- **Dynamic Expiry Status:** The UI provides at-a-glance information about the remaining days for each product and highlights items that are about to expire.
- **Intuitive Gestures:** A smooth **swipe-to-delete** gesture with a confirmation dialog prevents accidental deletions.
- **Polished & Themed UI:** A clean, user-friendly interface built with Material 3, featuring a custom theme, fonts, and thoughtful layout design.

## 🛠️ Tech Stack


- **Framework:** Flutter
- **Language:** Dart
- **Database:** `sqflite` for local relational storage.
- **State Management:** `setState` (simple, built-in state management).

## 🏃 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

You need to have Flutter installed on your system. You can find instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1.  Clone the repo
    ```sh
    git clone [https://github.com/oguzcankaraman/your_repository_name.git](https://github.com/your_username/your_repository_name.git)
    ```
2.  Navigate to the project directory
    ```sh
    cd akilli_kilername
    ```
3.  Install dependencies
    ```sh
    flutter pub get
    ```
4.  Run the app
    ```sh
    flutter run
    ```
