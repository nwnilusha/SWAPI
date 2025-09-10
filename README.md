# Star Wars Planets iOS App

A simple SwiftUI iOS app that displays the Star Wars Planets using the [SWAPI API](https://swapi.info/api/planets).

## Features
- List of planets with:
  - Placeholder image
  - Planet Name
  - Climate
- Detail view with more information about the selected planet
- Pull-to-refresh functionality
- Search planets by name
- Offline/No-network detection and auto-refresh when network is restored
- Data caching
- Localization support (English, Spanish, French)
- UI Tests
- Unit tests for API layer and ViewModels
- Support for light and dark themes (system default + manual toggle)

## Tech Stack
- **Swift** Development language
- **MVVM-C architecture**
- **SwiftUI** for UI
- **Async/await** for networking
- **URLSession** for API calls
- **Dependency Injection**
- **AsyncImage** for remote image loading
- **Network Monitoring** using `NWPathMonitor`
- **Unit/UI Testing** with XCTest

## Project Structure
Features/ 
- PlanetList/ – List of planets
- PlanetDetail/ – Detailed planet info
- Settings/ – User preferences and theming

Core/ 
- Networking/ → APIClient.swift
- NetworkMonitor/ → NetworkMonitor.swift
- Theme/ → ThemeManager.swift
- Extensions/ → Bundle extensions
- Coordinators/ → AppCoordinator.swift
- Components/ → Shared UI elements
- Mocks/ → mock data/services for previews and tests
  
Resources/
- Assets.xcassets
-  Localizable.strings (for localization)
  
Tests/
- Unit Test
- UI Test

## Requirements
- Minimum iOS Version: 17.6  
- Xcode: 16.4  

## How to Run
1. Clone the repository:
```bash
git clone https://github.com/nwnilusha/SWAPI.git
```
2. Open `SWAPI.xcodeproj` in Xcode.
3. Build and run on Simulator or device.

## Theming
- Uses iOS system-provided **dynamic colors** for automatic light/dark adaptation.
- Includes a manual theme picker (System / Light / Dark).

## Possible Improvements
- Offline capability with SwiftData/CoreData

## License
This project is for interview/demo purposes only and uses the free SWAPI public API.
