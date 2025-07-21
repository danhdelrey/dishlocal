# DishLocal

A social media food app that connects food enthusiasts to discover, share, and explore local dishes and culinary experiences.

## Project Overview

DishLocal is a Flutter-based mobile application designed to create a vibrant community around food discovery and sharing. Users can capture, share, and discover local dishes while connecting with fellow food lovers in their area and beyond.

### Goals

- **Discover Local Cuisine**: Help users find authentic local dishes and hidden culinary gems
- **Build Food Community**: Connect food enthusiasts and create meaningful interactions around shared culinary experiences
- **Share Culinary Stories**: Enable users to document and share their food discoveries with rich media and location context
- **Promote Local Food Culture**: Support local restaurants and food vendors by increasing their visibility

## Architecture

DishLocal follows a clean architecture pattern with clear separation of concerns:

```
lib/
├── app/                    # App-level configuration
│   ├── config/            # App router and configuration
│   └── theme/             # App theming and styling
├── core/                  # Core business logic and utilities
│   ├── app_environment/   # Environment configuration
│   ├── dependencies_injection/ # Service locator setup
│   ├── infrastructure/    # External service interfaces
│   ├── json_converter/    # JSON serialization utilities
│   └── utils/            # Common utilities
├── data/                 # Data layer implementation
├── ui/                   # Presentation layer
│   ├── features/         # Feature-specific UI components
│   └── widgets/          # Reusable UI components
└── main.dart             # Application entry point
```

### Technical Stack

- **Framework**: Flutter 3.5.4+
- **State Management**: BLoC pattern with flutter_bloc
- **Architecture**: Clean Architecture with dependency injection
- **Backend Services**: 
  - Supabase (primary database)
  - Firebase (authentication and storage)
- **Maps**: Mapbox integration for location features
- **Image Processing**: Advanced image handling with caching and optimization
- **Navigation**: Go Router for declarative routing

## Main Features

### 🔐 Authentication & User Management
- Email/password and Google Sign-In integration
- Comprehensive user profiles with customizable information
- Account setup and onboarding flow

### 📸 Content Creation & Sharing
- **Camera Integration**: High-quality photo capture with advanced camera controls
- **Post Creation**: Rich post creation with images, descriptions, and location tagging
- **Food Categorization**: Organize dishes by cuisine type and category

### 🌍 Location & Discovery
- **Location-based Discovery**: Find dishes and restaurants near you
- **Interactive Maps**: Mapbox-powered map integration for location visualization
- **Address Management**: Current location detection and address management

### 👥 Social Features
- **Follow System**: Follow other food enthusiasts and build your network
- **Reactions & Comments**: Engage with posts through likes, comments, and reactions
- **User Interactions**: Rich social interaction system with notifications

### 🔍 Search & Exploration
- **Advanced Search**: Powerful search with Algolia integration
- **Filtering & Sorting**: Comprehensive filtering options for content discovery
- **Suggestion System**: Smart search suggestions and recommendations

### ⭐ Reviews & Ratings
- **Rating System**: Rate dishes and restaurants with detailed reviews
- **Review Management**: Create, edit, and manage your reviews

### 📱 User Experience
- **Offline Support**: Connectivity checking and offline functionality
- **Infinite Scroll**: Smooth pagination for browsing content
- **Shimmer Loading**: Beautiful loading states and animations
- **Dark Mode Support**: Comprehensive theming with dark mode

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (version 3.5.4 or higher)
  ```bash
  flutter --version
  ```
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development on macOS)
- **Git** for version control

### Platform-specific Requirements

#### Android
- Android SDK (API level 21 or higher)
- Android Studio with Android SDK tools

#### iOS (macOS only)
- Xcode 12.0 or higher
- iOS Simulator or physical iOS device
- CocoaPods for dependency management

### Backend Services Setup

1. **Supabase Project**
   - Create a project at [supabase.com](https://supabase.com)
   - Note your project URL and anon key

2. **Firebase Project** (optional, for additional features)
   - Create a project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication and Storage services
   - Download configuration files

3. **Mapbox Account**
   - Create an account at [Mapbox](https://www.mapbox.com)
   - Generate an access token for map features

4. **Algolia Account** (for search)
   - Create an account at [Algolia](https://www.algolia.com)
   - Set up search indices

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/danhdelrey/dishlocal.git
   cd dishlocal
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Environment Configuration**
   ```bash
   # Create environment file
   cp .env.example .env
   
   # Edit .env with your API keys and configuration
   # SUPABASE_URL=your_supabase_url
   # SUPABASE_ANON_KEY=your_supabase_anon_key
   # MAPBOX_ACCESS_TOKEN=your_mapbox_token
   # ALGOLIA_APP_ID=your_algolia_app_id
   # ALGOLIA_API_KEY=your_algolia_api_key
   ```

4. **Generate required files**
   ```bash
   # Generate dependency injection and JSON serialization
   flutter packages pub run build_runner build
   ```

5. **Firebase Setup** (if using Firebase features)
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   
   # Login and configure
   firebase login
   firebase use --add
   ```

## Usage

### Development

1. **Run the app in development mode**
   ```bash
   # For Android
   flutter run --flavor dev --target lib/main.dart
   
   # For iOS
   flutter run --flavor dev --target lib/main.dart
   ```

2. **Run with hot reload for rapid development**
   ```bash
   flutter run --hot
   ```

3. **Run tests**
   ```bash
   # Run all tests
   flutter test
   
   # Run tests with coverage
   flutter test --coverage
   ```

4. **Code generation and analysis**
   ```bash
   # Generate code (run when you modify @freezed or @injectable classes)
   flutter packages pub run build_runner build --delete-conflicting-outputs
   
   # Analyze code
   flutter analyze
   
   # Format code
   flutter format lib/
   ```

### Building for Production

1. **Android APK**
   ```bash
   flutter build apk --flavor prod --target lib/main.dart
   ```

2. **Android App Bundle (recommended for Play Store)**
   ```bash
   flutter build appbundle --flavor prod --target lib/main.dart
   ```

3. **iOS (macOS only)**
   ```bash
   flutter build ios --flavor prod --target lib/main.dart
   ```

### Environment Management

The app supports multiple environments:

- **Development**: `--flavor dev` - Uses development backend services
- **Production**: `--flavor prod` - Uses production backend services

## Contributing

We welcome contributions to DishLocal! Please follow these guidelines:

### Getting Started

1. **Fork the repository** and create your feature branch
   ```bash
   git checkout -b feature/amazing-feature
   ```

2. **Set up your development environment** following the installation instructions above

3. **Make your changes** following our coding standards

### Coding Standards

- **Follow Flutter/Dart conventions**: Use `flutter analyze` to check for issues
- **Use BLoC pattern**: All state management should follow the established BLoC pattern
- **Write tests**: Add unit tests for business logic and widget tests for UI components
- **Code formatting**: Run `flutter format` before committing
- **Clean architecture**: Maintain separation between presentation, domain, and data layers

### Code Style Guidelines

- Use **2-space indentation** (as configured in the project)
- Follow **camelCase** for variables and methods
- Use **PascalCase** for classes and enums
- Add **meaningful comments** for complex business logic
- Keep **functions small** and focused on single responsibilities

### Commit Guidelines

- Use **conventional commits** format: `type(scope): description`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- Example: `feat(auth): add Google Sign-In integration`

### Pull Request Process

1. **Update documentation** if you've made changes to public APIs
2. **Add or update tests** for your changes
3. **Ensure all tests pass** locally before submitting
4. **Update the README.md** if you've added new features or changed setup instructions
5. **Request review** from maintainers

### Issues and Feature Requests

- Use **GitHub Issues** to report bugs or request features
- Provide **detailed descriptions** and steps to reproduce for bugs
- Include **mockups or wireframes** for UI-related feature requests

## License

This project is currently under development. License information will be updated as the project matures.

For questions about licensing, please contact the project maintainers.

---

## Support

For support, feature requests, or contributions:

- **Issues**: [GitHub Issues](https://github.com/danhdelrey/dishlocal/issues)
- **Discussions**: [GitHub Discussions](https://github.com/danhdelrey/dishlocal/discussions)

---

**Made with ❤️ by the DishLocal team**
