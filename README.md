
## Screenshots

<p float="left">
  <img src="https://github.com/fareselsokary/MoviesApp/blob/main/ScreenShots/Home.png?raw=true" width="180" /> 
  <img src="https://github.com/fareselsokary/MoviesApp/blob/main/ScreenShots/Details.png?raw=true" width="180" />
</p>


# MoviesApp

MoviesApp is a simple, enjoyable way to explore movies on your iPhone. You can browse trending titles, search by genre, and see all the details you care about. Plus, it saves your recent results, so you can quickly pick up where you left off anytime.


## Getting Started

To get a copy of the project up and running on your local machine, follow these steps.

### Prerequisites
- Xcode 16.3+
- macOS 15.5+

### Installation

1- **Clone the repository**:
   ```bash
   git clone git@github.com:fareselsokary/MoviesApp.git
   ```

2- **Open in Xcode**:
   ```bash
   open MoviesApp.xcodeproj
   ```

3- **Configure the TMDB API key**:
   Add your TMDB API key to the `Constants` file located at:
   ```
   MoviesApp/Modules/Core/Sources/Core/Constants/
   ```
   This file contains the API configuration settings required for fetching movie data.

4- **Build and Run**:  
   Select a simulator/device in Xcode and press `Cmd + R`.

## Table of Contents

* [Getting Started](#getting-started)
* [Features](#features)
* [Architecture](#architecture)
* [Technologies Used](#technologies-used)
* [Project Structure](#project-structure)



### Features

-  Browse trending movies with infinite pagination  
-  Search movies by keyword or genre  
-  View movie details with poster and other details like title, image, release date, genres...  
-  Offline data support (using SwiftData)   
-  Scalable architecture using MVVM + Combine 

## Architecture

This project adopts a clean and modular architecture, aiming for separation of concerns and maintainability. Key architectural layers include:

- **API** — Handles all interactions with external APIs.

- **Core** — Contains foundational utilities, constants, extensions, and common UI modifiers.

- **Domain** — Defines the core business logic and models, independent of any specific framework.

- **Features** — Encapsulates distinct features of the application, promoting reusability and isolation.

- **Mapper** — Responsible for transforming data between different layers (e.g., API responses to Domain models).

- **Networking** — Manages network requests, configurations, and reachability.

- **Persistence** — Handles data storage and retrieval, specifically utilizing **SwiftData** for offline capabilities.

- **Repository** — Provides an abstraction layer over data sources (network, persistence), allowing the Domain layer to remain unaware of the underlying data fetching mechanism.

- **Routing** — Manages navigation within the application.

## Technologies Used

- **SwiftUI** — Declarative UI framework for building native Apple applications.
- **Combine** — Apple's framework for handling asynchronous events by combining event-processing operators.
- **SwiftData** — A modern framework for managing and persisting application data.
- **Swift Package Manager (SPM)** — Used for dependency management and modularizing the project.

## Project Structure

The project is organized into several modules and folders, promoting a clean and scalable architecture. Here's a high-level overview:


```
MoviesApp/
├── Modules/
│   ├── API/                  # API client and service definitions
│   │   ├── Package/
│   │   ├── Sources/
│   │   └── Tests/
│   ├── Core/                 # Core utilities, extensions, constants, common UI components
│   │   ├── Package/
│   │   ├── Sources/
│   │   │   ├── Constants/
│   │   │   ├── Extensions/
│   │   │   ├── Logger/
│   │   │   └── ViewModifier/
│   │   └── Tests/
│   ├── Domain/               # Business logic, models (e.g., GenreModel, MovieModel)
│   │   ├── Package/
│   │   ├── Sources/
│   │   └── Tests/
│   ├── Features/             # Independent feature modules (e.g., MovieList, MovieDetail)
│   │   ├── Package/
│   │   ├── Sources/
│   │   └── Tests/
│   ├── Mapper/               # Data transformation (e.g., GenreMapper, MovieModelMapper)
│   │   ├── Package/
│   │   ├── Sources/
│   │   └── Tests/
│   ├── Networking/           # Network layer: Endpoints, HTTP Methods, Service, Reachability
│   │   ├── Package/
│   │   ├── Sources/
│   │   └── Tests/
│   ├── Persistence/          # SwiftData models and persistence manager
│   │   ├── Package/
│   │   ├── Sources/
│   │   └── Tests/
│   ├── Repository/           # Abstraction for data sources (e.g., GenresRepository, MovieRepository)
│   │   ├── Package/
│   │   ├── Sources/
│   │   └── Tests/
│   └── Routing/              # Navigation logic (e.g., AppRouter, Router)
│       ├── Package/
│       ├── Sources/
│       └── Tests/
├── MoviesApp/                # Main application target
│   ├── Assets.xcassets/
│   ├── ContentView.swift
│   ├── Info.plist
│   └── Launch Screen.storyboard
```
