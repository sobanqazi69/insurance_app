# Insurance App

A professional Flutter-based mobile application for insurance management and services, built with clean architecture and BLoC pattern.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **BLoC (Business Logic Component)** pattern for state management:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants and configurations
│   ├── errors/             # Error handling and failures
│   ├── network/            # Network utilities and HTTP client
│   ├── theme/              # App theming and styling
│   ├── utils/              # Utility functions
│   └── widgets/            # Shared UI components
├── features/               # Feature modules (Clean Architecture)
│   ├── auth/              # Authentication feature
│   │   ├── bloc/          # BLoC for state management
│   │   ├── data/          # Data layer
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/        # Domain layer
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/  # Presentation layer
│   │       ├── pages/
│   │       └── widgets/
│   ├── home/              # Home feature
│   ├── profile/           # Profile feature
│   ├── policies/          # Insurance policies feature
│   ├── claims/            # Claims management feature
│   └── payments/          # Payment processing feature
└── shared/                # Shared components
    ├── models/            # Shared data models
    ├── services/          # Shared services
    └── widgets/           # Shared UI widgets
```

## 🚀 Features

- **Authentication & Authorization**
  - User registration and login
  - Secure token management
  - Password reset functionality
  - Email verification

- **Insurance Management**
  - Policy browsing and selection
  - Policy details and documents
  - Policy renewal and cancellation
  - Premium calculation

- **Claims Processing**
  - File new claims
  - Track claim status
  - Upload supporting documents
  - Claim history

- **Payment Processing**
  - Multiple payment methods
  - Payment history
  - Recurring payments
  - Payment reminders

- **User Profile**
  - Personal information management
  - Document upload
  - Notification preferences
  - Account settings

## 🛠️ Tech Stack

### State Management
- **flutter_bloc** - BLoC pattern implementation
- **equatable** - Value equality for objects
- **dartz** - Functional programming utilities

### Navigation
- **go_router** - Declarative routing solution

### Network & API
- **dio** - HTTP client with interceptors
- **retrofit** - Type-safe HTTP client
- **json_annotation** - JSON serialization

### Local Storage
- **shared_preferences** - Key-value storage
- **hive** - NoSQL database
- **hive_flutter** - Flutter integration

### UI & Design
- **google_fonts** - Custom typography
- **flutter_svg** - SVG support
- **cached_network_image** - Image caching
- **shimmer** - Loading animations
- **lottie** - Animation support
- **flutter_screenutil** - Responsive design

### Authentication
- **firebase_auth** - Firebase authentication
- **firebase_core** - Firebase core
- **google_sign_in** - Google sign-in

### Utilities
- **intl** - Internationalization
- **uuid** - Unique identifiers
- **permission_handler** - Permission management
- **image_picker** - Image selection
- **file_picker** - File selection
- **url_launcher** - URL handling
- **connectivity_plus** - Network connectivity
- **device_info_plus** - Device information
- **package_info_plus** - App information

### UI Components
- **flutter_staggered_animations** - Staggered animations
- **pull_to_refresh** - Pull-to-refresh functionality
- **flutter_local_notifications** - Local notifications

### Data Visualization
- **fl_chart** - Charts and graphs

### Documents & PDF
- **pdf** - PDF generation
- **printing** - Print functionality

### QR & Barcode
- **qr_flutter** - QR code generation
- **mobile_scanner** - Barcode scanning

## 📱 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/sobanqazi69/insurance_app.git
   cd insurance_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate code:**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## 🏛️ Architecture Patterns

### Clean Architecture
The app follows Clean Architecture principles with three main layers:

1. **Presentation Layer** - UI components and BLoC
2. **Domain Layer** - Business logic and entities
3. **Data Layer** - Data sources and repositories

### BLoC Pattern
State management using BLoC pattern:
- **Events** - User actions and system events
- **States** - UI states and data
- **BLoC** - Business logic and state transitions

### Repository Pattern
Data access abstraction:
- **Repository Interface** - Contract for data operations
- **Repository Implementation** - Concrete implementation
- **Data Sources** - Remote and local data sources

## 📁 Project Structure Details

### Core Module
```
core/
├── constants/
│   ├── app_constants.dart      # App-wide constants
│   └── api_endpoints.dart      # API endpoint definitions
├── errors/
│   └── failures.dart           # Error handling classes
├── network/
│   ├── dio_client.dart         # HTTP client configuration
│   └── network_info.dart       # Network connectivity
├── theme/
│   ├── app_colors.dart         # Color definitions
│   └── app_theme.dart          # Theme configuration
├── utils/                      # Utility functions
└── widgets/                    # Shared UI components
```

### Feature Module (Example: Auth)
```
features/auth/
├── bloc/
│   ├── auth_bloc.dart          # Main BLoC
│   ├── auth_event.dart         # BLoC events
│   └── auth_state.dart         # BLoC states
├── data/
│   ├── datasources/
│   │   └── auth_remote_datasource.dart
│   ├── models/
│   │   └── user_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       ├── register_usecase.dart
│       ├── logout_usecase.dart
│       └── check_auth_status_usecase.dart
└── presentation/
    ├── pages/
    │   ├── login_page.dart
    │   ├── register_page.dart
    │   └── splash_page.dart
    └── widgets/
        └── auth_widgets.dart
```

## 🔧 Configuration

### Environment Setup
1. Create environment-specific configuration files
2. Set up API endpoints for different environments
3. Configure Firebase project settings
4. Set up signing configurations for app distribution

### API Configuration
- Base URL configuration in `lib/core/constants/api_endpoints.dart`
- HTTP client setup in `lib/core/network/dio_client.dart`
- Error handling and interceptors

### Theme Configuration
- Color schemes in `lib/core/theme/app_colors.dart`
- Theme data in `lib/core/theme/app_theme.dart`
- Custom typography and component styles

## 🧪 Testing

### Unit Tests
- BLoC testing
- Use case testing
- Repository testing
- Utility function testing

### Widget Tests
- Page testing
- Widget testing
- Integration testing

### Test Structure
```
test/
├── unit/                      # Unit tests
├── widget/                    # Widget tests
└── integration/               # Integration tests
```

## 📦 Build & Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Open an issue in the GitHub repository
- Check the documentation
- Review the code examples

## 🔄 Version History

- **v1.0.0** - Initial release with basic features
  - Authentication system
  - Basic UI structure
  - BLoC pattern implementation
  - Clean architecture setup

## 📞 Contact

- **Developer**: Soban Qazi
- **Email**: [Your Email]
- **GitHub**: [sobanqazi69](https://github.com/sobanqazi69)

---

**Note**: This is a professional-grade Flutter application following industry best practices and modern development patterns. The codebase is designed to be scalable, maintainable, and testable.
