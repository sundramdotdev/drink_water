# 💧 Drink Water

A simple, intuitive, and responsive Flutter-based mobile application designed to help users track their daily water intake and stay hydrated.

## 🚀 Features

* [cite_start]**Daily Tracking:** Easily log water consumption with preset buttons (e.g., 250ml, 500ml). [cite: 87]
* [cite_start]**Visual Progress:** Monitor your daily goal progress through a clean, container-based UI. [cite: 88]
* [cite_start]**Responsive UI:** Built with Flutter's layout engine to ensure a consistent experience across different screen sizes. [cite: 89]
* [cite_start]**Data Persistence:** Your progress is saved locally, so your data persists even after closing the app. [cite: 90]
* [cite_start]**Material Design:** Implemented using standard Material components for a native Android look and feel. [cite: 91]

## 🛠 Tech Stack

* [cite_start]**Framework:** Flutter (Dart) [cite: 92]
* [cite_start]**State Persistence:** `shared_preferences` for local data storage [cite: 92]
* [cite_start]**UI Components:** `Scaffold`, `Column`, `Row`, `Container`, `Expanded` [cite: 92]

## 🏗 Key Architectural Concepts

The app leverages the core Flutter widget tree to manage layout and state:

* [cite_start]**`Scaffold`**: Serves as the primary skeleton, managing the `appBar`, `body`, and interaction elements like the `floatingActionButton`. [cite: 92]
* [cite_start]**Layout Logic**: Uses `Column` for vertical stacking and `Row` for horizontal alignment, with `Expanded` widgets to ensure responsiveness across devices. [cite: 93]
* [cite_start]**Visuals**: Uses `Container` with `BoxDecoration` for progress visualization and custom styling. [cite: 94]

## 💻 How to Run

1.  **Clone the repository:**
    ```bash
    git clone [your-repo-url]
    ```
2.  **Run the app:**
    ```bash
    flutter run
    ```

---

*Made with ❤️ using Flutter.*
