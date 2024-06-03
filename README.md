# Movie and TV Series Search Application

Welcome to the Movie and TV Series Search Application! This project leverages the OMDB API to provide a comprehensive search experience for movies and TV series. The application is being modularized to enhance maintainability and scalability. The current modular structure includes `Mcore` and `Mnetwork`, with plans to add `MAppUI` and `MLogin`.

## Features

- Search for movies and TV series using the OMDB API.
- View detailed information about each title, including plot, ratings, and more.
- Developed with both UIKit and SwiftUI frameworks.

## Modular Structure

The project is being refactored into a modular structure for better separation of concerns and code organization.

### Completed Modules

- [x] **[Mcore](https://github.com/canamaemindevar/MCore/tree/1.0.1)**: Contains the core models and business logic.
- [x] **[Mnetwork](https://github.com/canamaemindevar/MNetwork/tree/develop)**: Manages network requests and API interactions.

### Planned Modules

- [ ] **MAppUI**: Will handle all UI components and views.
- [ ] **MLogin**: Will manage user authentication and login functionality.

## Technologies and Libraries

- **Protocol Oriented Programming**
- **Programmatic UI**
- **MVVM**
- **Delegate Pattern**
- **Dependency Injection**
- **Generic Network**
- **Compositional Layout**
- **UIPickerView**
- **Unit Tests**
- **UIKit**
- **SwiftUI**
- **UserDefaults**

## Installation

To run this project locally, follow these steps:

1. Clone the repository:
   ```sh
   git clone https://github.com/canamaemindevar/MovieApp.git

2. Navigate to the desired branch:
   ```sh
   git checkout <branch-name>
3. Open the project in Xcode:
   ```sh
  open MovieApp.xcodeproj
4. Build and run the application:
   ```sh
   Cmd + R
