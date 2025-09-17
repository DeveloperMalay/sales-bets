# 🎯 Sales Bets - No-Loss Betting App

A Flutter mobile application that gamifies sales team performance through a unique no-loss betting system. Users can place bets on sales events and teams without ever losing their credits, creating an engaging and risk-free experience.

## 📱 Features

### 🎮 Core Betting System
- **No-Loss Mechanic**: Users never lose credits when bets don't win
- **Dynamic Event Cards**: Real-time status showing betting state per event
- **Real-Time Animations**: Confetti celebrations for wins, encouraging messages for losses
- **Smart Odds System**: Different multipliers based on team performance

### 🏆 Gamification
- **Achievement System**: 15+ achievements with progress tracking
- **Dynamic Leaderboards**: Rankings based on total earnings and performance
- **Team Following**: Users can follow their favorite sales teams
- **Win Streak Tracking**: Monitor consecutive wins and performance

### 📊 User Experience
- **Beautiful UI**: Modern gradient design with smooth animations
- **Real-Time Updates**: Live event status and bet result notifications
- **Pull-to-Refresh**: Easy data updates across the app
- **Responsive Design**: Optimized for all screen sizes

### 🔔 Notifications
- **Push Notifications**: Instant alerts for bet results
- **FCM Integration**: Reliable Firebase Cloud Messaging
- **User-Specific Topics**: Targeted notifications per user

### 🎥 Live Streaming
- **Live Events**: Watch sales competitions in real-time
- **Chat Integration**: Interactive chat during live streams
- **Stream Discovery**: Browse trending and live streams

### 🔐 Authentication & Data
- **Firebase Auth**: Secure user authentication
- **Anonymous Sign-In**: Quick start without registration
- **Real-Time Database**: Firestore for live data synchronization
- **Data Validation**: Comprehensive error handling and validation

## 🏗️ Architecture

### 📁 Project Structure
```
lib/
├── core/
│   ├── constants/          # App constants and configuration
│   ├── routing/           # Go Router navigation setup
│   └── themes/            # App themes and styling
├── cubits/               # Global state management
├── models/               # Data models (User, Event, Bet, Team)
├── screens/              # UI screens with BLoC pattern
│   ├── auth/            # Authentication screens
│   ├── betting/         # Betting interface
│   ├── home/            # Main dashboard
│   ├── profile/         # User profile management
│   └── dev/             # Developer tools
├── services/            # External services and APIs
└── widgets/             # Reusable UI components
```

### 🧱 State Management
- **BLoC Pattern**: Clean separation of business logic and UI
- **Cubit Implementation**: Simplified state management for each feature
- **Real-Time Streams**: Live data updates using Firestore streams

### 🌐 Navigation
- **Go Router**: Declarative routing with deep linking support
- **Shell Routes**: Persistent bottom navigation
- **Auth Guards**: Protected routes based on authentication state

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+
- Firebase project with Firestore and Authentication enabled
- Android Studio / VS Code with Flutter extensions

### 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd sales_bets
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   
   # Configure Firebase for Flutter
   flutterfire configure
   ```

4. **Environment Configuration**
   Create a `.env` file in the root directory:
   ```env
   FIREBASE_PROJECT_ID=your_project_id
   FCM_SERVER_KEY=your_fcm_server_key
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### 📊 Firebase Setup

#### Firestore Collections
```
users/
├── {userId}/
│   ├── credits: 1000
│   ├── betIds: []
│   ├── totalWins: 0
│   └── achievements: []

events/
├── {eventId}/
│   ├── title: "Q1 Revenue Challenge"
│   ├── status: "live"
│   ├── teams: []
│   └── odds: {}

bets/
├── {betId}/
│   ├── userId: "..."
│   ├── eventId: "..."
│   ├── creditsStaked: 500
│   └── status: "pending"

teams/
├── {teamId}/
│   ├── name: "Alpha Squad"
│   ├── wins: 15
│   └── followers: 234
```

#### Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /events/{eventId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null; // Add admin checks
    }
    
    match /bets/{betId} {
      allow read, write: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
  }
}
```

### 🔧 Development Tools

#### Developer Screen
Access via Profile → Developer Tools:
- **Create Events**: Add new betting events
- **Manage Teams**: Create and edit sales teams
- **Complete Events**: Simulate event completion with winner selection
- **User Management**: View and modify user data

#### Debug Features
- Comprehensive logging throughout the app
- Real-time state inspection
- Network request monitoring
- Animation debugging

## 🎯 Key Features Deep Dive

### No-Loss Betting Mechanics
```dart
// Users start with 1000 credits
// Bets never decrease user credits
// Only winning bets add to credit balance

if (betResult == BetStatus.won) {
  final netWinnings = creditsWon - creditsStaked;
  userCredits += netWinnings; // Only add profit
} else {
  // Credits remain unchanged - no loss!
}
```

### Real-Time Animations
- **Home Screen**: Automatic win/loss animations for recent bet results
- **Betting Screen**: Confetti celebrations for completed events
- **Wallet Card**: Scale animations during credit updates
- **Event Cards**: Dynamic status indicators

### Achievement System
15 unique achievements including:
- 🎯 **First Bet**: Place your first bet
- 🔥 **Hot Streak**: Win 3 bets in a row
- 💰 **Big Winner**: Win 1000+ credits in a single bet
- 🏆 **High Roller**: Stake 500+ credits on a bet
- ⭐ **VIP Status**: Earn 5000+ total credits

### Push Notifications
```dart
// Automatic notifications for:
- Bet wins/losses
- New events available
- Achievement unlocks
- Following team wins
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Test Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc: ^8.1.3` - State management
- `go_router: ^10.1.2` - Navigation
- `firebase_core: ^2.15.1` - Firebase integration
- `cloud_firestore: ^4.9.1` - Database
- `firebase_auth: ^4.9.0` - Authentication
- `firebase_messaging: ^14.6.7` - Push notifications

### UI/UX Dependencies
- `animate_do: ^3.0.2` - Smooth animations
- `confetti: ^0.7.0` - Celebration effects
- `flutter_dotenv: ^5.1.0` - Environment configuration

### Development Dependencies
- `freezed: ^2.4.6` - Immutable data classes
- `json_annotation: ^4.8.1` - JSON serialization
- `build_runner: ^2.4.6` - Code generation

## 🚀 Deployment

### Android Release
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS Release
```bash
flutter build ios --release
```

### Firebase Hosting (Web)
```bash
flutter build web
firebase deploy --only hosting
```

## 📈 Performance Optimization

### Implemented Optimizations
- **Firestore Query Optimization**: Efficient data fetching with proper indexing
- **Image Caching**: Optimized image loading and caching
- **State Management**: Minimal rebuilds with targeted BLoC emissions
- **Animation Performance**: Hardware-accelerated animations
- **Memory Management**: Proper disposal of controllers and streams

### Monitoring
- Firebase Performance Monitoring
- Crashlytics for error tracking
- Analytics for user behavior insights

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Add comments for complex business logic
- Maintain consistent file organization

### Git Commit Convention
- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation updates
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Test additions/updates

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Firebase team for excellent backend services
- Flutter community for amazing packages
- Design inspiration from modern betting and gaming apps
- Sales teams for real-world insights into gamification

## 📞 Support

For support, questions, or feature requests:
- Open an issue on GitHub
- Contact the development team
- Check the documentation wiki

---

**Built with ❤️ using Flutter and Firebase**

*Transform your sales team performance with engaging, risk-free betting!*
