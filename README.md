Firebase Parking System 🚗
A  parking management system built with Flutter and Firebase, featuring real-time parking session tracking, vehicle management, and user profiles.
🌟 Featuresasdasd
🔐 Authenticationasdasdasd
aaaa
User registration and login with Firebase Auth
Secure user sessions with automatic logout
Profile management with personal informationasdasdaasd

🚗 Vehicle Managemen  
 
Register multiple vehicles per user in a day
Support for different vehicle types (Car, Motorcycle, Truck, Van, Bus)asdasdkjkj
Real-time vehicle data synchronization
Edit and delete vehicle functionalitystyasd
Registration number validation to prevent duplicatesasd

🅿️ Parking System

Start and end parking sessions in thatasd
Real-time parking space availability
Automatic parking space status updates
Duration tracking and fee calculation
Support for hourly rates
Prevent double parking (one vehicle per space)

📊 User Dashboard

Clean profile interface with user information
Real-time vehicle list with management options
Parking history with detailed session information
Active parking session indicatorsasdasdasd
Fee calculations and duration tracking

🎨 Modern UI/UX

Dark and light theme support
Terminal-style dark mode with monospace fonts
Material Design 3 components
Responsive design for different screen sizes
Clean expandable sections with smooth animationsasdasd

🏗️ Architectureasdsa
This app follows Clean Architecture principles with clear separation of concerns:kjkjkjlklk
lib/asdasd
├── core/                     # Core utilities and errors
│   └── errors/
│       └── failures.dart
├── data/                     # Data layer
│   ├── datasources/         # Remote data lkklk link that in that
│   │   ├── vehicle_remote_datasource.dart
│   │   └── parking_data_source.dart
│   ├── models/              # Data models
│   │   ├── vehicles/aaa
│   │   ├── parking/
│   │   └── person/
│   └── repositories/        # Repository implementations
│       └── vehicle_repository_impl.dart
├── domain/                  # Business logic layer
│   ├── entities/           # Core business entities
│   │   ├── vehicle_entity.dart
│   │   └── parking_entity.dart
│   ├── repositories/       # Repository interfaces
│   │   └── vehicle_repository.dart
│   └── usecases/          # Business use cases
│       ├── vehicles/
│       └── parking/
└── presentation/           # UI layer
    ├── blocs/             # State managementta
    │   ├── auth/
    │   ├── vehicle/
    │   └── parking/
    └── screens/           # UI screens
        └── profile_screen.dart
🧩 Key Components

Entities: Core business objects (Vehicle, Parking, User)
Repositories: Abstract interfaces for data operations
Data Sources: Firebase Firestore integration
BLoC Pattern: State management with flutter_bloc
Use Cases: Individual business operations

🛠️ Tech Stack
Frontend

Flutter - Cross-platform mobile framework
flutter_bloc - State management
material_design_icons_flutter - Icon library
equatable - Value equality
dartz - Functional programming utilities

Backend

Firebase Auth - User authentication
Cloud Firestore - Real-time database
Firebase Security Rules - Data access control

Architecture Patterns

Clean Architecture - Separation of concerns
BLoC Pattern - Predictable state management
Repository Pattern - Data abstraction
Use Case Pattern - Business logic encapsulation

📱 Screenshots
Profile Screen

User information display
Vehicle management section
Parking history overview
Dark/light theme toggle

Vehicle Management

Vehicle registration form
Vehicle type selection
Real-time vehicle updates
Edit/delete functionality

Parking Sessions

Active parking indicators
Duration and fee tracking
Parking space management
Session history

🚀 Getting Started
Prerequisites

Flutter SDK (3.0+)
Dart SDK (3.0+)
Firebase project setup
Android Studio / VS Code

Firebase Configuration
Firestore Collections
users/{userId}
├── name: string
├── email: string
├── personalNumber: string
└── createdAt: timestamp

vehicles/{vehicleId}
├── registration_number: string
├── type: string
├── owner_id: string
└── created_at: timestamp

parking/{parkingId}
├── vehicle_id: string
├── parking_space_id: string
├── started_at: timestamp
├── finished_at: timestamp (nullable)
└── hourly_rate: number

parking_spaces/{spaceId}

├── space_number: string
├── status: string ('vacant' | 'occupied')
├── vehicle_id: string (nullable)
└── hourly_rate: number


Made with ❤️ and Flutter

