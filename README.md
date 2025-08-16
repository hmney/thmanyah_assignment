# Radio Thmanyah – iOS

A **Clean Architecture** iOS app showcasing a mixed-media Home feed and Search with **SwiftUI**, **Alamofire** networking, **Container** for dependency injection and modular navigation using **Coordinator** & **Router** pattern.

---

## ✨ Features

- **Home**: Mixed sections (Podcasts, Episodes, Audiobooks, Articles)
- **Filtering** by content type via chips
- **Search**: Search for (Podcasts, Episodes, Audiobooks, Articles)
- **Coordinator + Router** navigation pattern
- **Kingfisher** image loading & caching
- **Scalable networking** with Alamofire + Endpoint builder
- **(Ready)** for offline caching

---

## 🏛 Architecture

This project follows a Clean Architecture pattern combined with the Coordinator + Router navigation approach.
The main goals of this structure are:
- Separation of concerns: Each layer has a single responsibility.
- Testability: Clear boundaries enable unit and integration testing.
- Scalability: Easy to extend with new features without breaking existing code.
- Reusability: Shared utilities and components are decoupled from feature-specific logic.

1. Core Layer
Contains shared infrastructure and foundation code used across all features.
```plaintext
Core/
 ├── UI/                  # Shared UI components, themes, and visual elements
 │    ├── Components/     # Reusable SwiftUI views (e.g., RemoteImage, LottieView)
 │    ├── Theme/          # Colors, typography, spacing constants
 ├── DI/                  # Dependency injection setup (DIContainer, Environment extensions)
 ├── Network/             # Network client and endpoint definition
 ├── Utils/               # Enums, extensions, formatters, utilities, modifiers
 ├── Architecture/        # Base Coordinator, Router, and ViewModel protocols
```

2. App Layer
Holds the application entry point and global configuration.
```plaintext
App/
 ├── RadioThmanyahApp.swift   # Main App entry point
 ├── AppCoordinator.swift     # Root Coordinator for managing navigation flow
 ├── AppDI.swift              # Dependency registration
 ├── AppViewModel.swift       # App-wide state management
 ├── AppRootView.swift        # Root SwiftUI view
```

3. Feature Modules
Each feature follows a modular Clean Architecture structure with Data, Domain, and Presentation layers.
Example: Features/Home/
```plaintext
Features/
 ├── Home/
 │    ├── Data/
 │    │    ├── DataSources/     # Local & remote data sources
 │    │    ├── Network/         # Endpoints for API requests
 │    │    ├── Repositories/    # Repository implementations
 │    │    ├── DTOs/            # Data Transfer Objects
 │    │    ├── Mappers/         # Map DTOs to domain entities
 │    ├── Domain/
 │    │    ├── Entities/        # Core business models
 │    │    ├── Repositories/    # Repository protocols
 │    │    ├── UseCases/        # Business logic (e.g., LoadHomeFirstPage)
 │    ├── Presentation/
 │    │    ├── ViewModels/      # State & logic for SwiftUI views
 │    │    ├── Coordinator/     # Handles navigation for the feature
 │    │    ├── Screens/         # SwiftUI screens
 │    │    ├── Components/      # Feature-specific UI components
 │    │    ├── Router/          # Route definitions & navigation handling
```

4. Coordinator + Router Pattern
- Coordinator: Manages navigation flows and view presentation.
- Router: Defines navigation routes for a specific feature.
- Factory pattern: Used for creating Coordinators and injecting dependencies.

5. Resources
Static assets, fonts, localized strings, and storyboard files.
```plaintext
Resources/
 ├── Assets.xcassets/      # Images & icons
 ├── Fonts/                # Custom font files
 ├── Launch Screen.storyboard
```

6. Testing
Tests are organized mirroring the production code structure.
```plaintext
Radio ThmanyahTests/
 ├── Core/                 # Core layer tests
 ├── Features/             # Feature-specific tests
 ├── Support/              # Test helpers (fixtures, decoders, async helpers)
 ├── Fixtures/             # JSON mock data
```

---

## Testing Strategy
- Unit Tests for ViewModels, UseCases, and Repositories.
- Integration Tests for Repository + DataSources.
- UI Tests with fixture-based responses for predictable results.

---

## ⚙️ Setup

### Requirements
- Xcode 16+
- iOS 17+

### Dependencies (Swift Package Manager)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Lottie](github.com/airbnb/lottie-ios)
- [SwiftUI-Shimmer](https://github.com/markiv/SwiftUI-Shimmer)

---

## 🚀 Building & Running

1. Open the project in **Xcode**  
2. Select a simulator or device  
3. **Run** the app (⌘ + R)

---

## Demo


https://github.com/user-attachments/assets/a1182a0d-efbf-4076-b7fe-8030da6a10b2

## WIP
Refactor/SPM-features branch for migrating the project into separate modules for each feature.

