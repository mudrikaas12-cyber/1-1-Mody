# Quick Start Guide - Mody Alumni Connect

Get the app running in 10 minutes! ⚡

## Prerequisites Checklist

- [ ] Flutter SDK installed (3.0.0+)
- [ ] Git installed
- [ ] Firebase account created
- [ ] IDE installed (VS Code or Android Studio)
- [ ] Android Studio / Xcode (for emulators)

## Step-by-Step Setup

### 1. Clone & Install (2 minutes)

```bash
# Clone repository
git clone https://github.com/yourusername/mody-alumni-connect.git
cd mody-alumni-connect

# Install dependencies
flutter pub get

# Check everything is working
flutter doctor
```

### 2. Firebase Setup (5 minutes)

#### Create Firebase Project
1. Go to https://console.firebase.google.com/
2. Click "Add Project" → Name it "Mody Alumni Connect"
3. Disable Google Analytics → Click "Create"

#### Install FlutterFire
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure project
flutterfire configure
```

Follow the prompts:
- Select your Firebase project
- Select platforms: Android, iOS
- This generates `lib/firebase_options.dart`

#### Enable Services in Firebase Console

**Authentication:**
1. Go to Authentication → Get Started
2. Enable Email/Password
3. Click Save

**Firestore:**
1. Go to Firestore Database → Create Database
2. Start in Test Mode
3. Select location (closest to you)
4. Click Enable

**Cloud Messaging:**
1. Go to Cloud Messaging
2. (Already enabled by default)

**Storage:**
1. Go to Storage → Get Started
2. Start in Test Mode
3. Click Done

### 3. Add Assets (1 minute)

```bash
# Create directories
mkdir -p assets/images assets/icons assets/fonts

# Download Poppins font from Google Fonts
# Place font files in assets/fonts/
```

Or skip fonts temporarily (app will use system fonts).

### 4. Run the App (2 minutes)

```bash
# Start an emulator or connect device
flutter devices

# Run the app
flutter run

# Or run on specific device
flutter run -d <device-id>
```

## Creating Test Accounts

### Option 1: Through the App
1. Open app → Click "Create Account"
2. Fill in details:
   - Name: Test Student
   - Email: student@test.com
   - Password: test123
   - Role: Student
   - Department: Engineering
3. Click "Create Account"

### Option 2: Via Firebase Console
1. Go to Authentication → Users
2. Click "Add User"
3. Enter email and password
4. Click "Add User"

Create accounts for all roles:
- `student@test.com` (Student)
- `alumni@test.com` (Alumni)
- `cdc@test.com` (CDC)

## Testing Features

### Student Flow
1. Login as student@test.com
2. Explore → See empty state (no alumni yet)
3. Profile → View your profile
4. Edit profile to add interests

### Alumni Flow
1. Login as alumni@test.com
2. Profile → Complete your profile
   - Add company, position
   - Add skills and mentoring areas
   - Toggle "Available for Mentorship"
3. Save changes

### CDC Flow
1. Login as cdc@test.com
2. Click "Post Alert"
3. Fill in notification details
4. Select audience
5. Post notification

### Testing Chat
1. Login as student
2. Go to Explore → Create alumni account if needed
3. Click on alumni profile
4. Click "Request Mentorship"
5. Login as alumni
6. Accept request
7. Both can now chat!

## Common Issues & Quick Fixes

### Issue: Firebase not initialized
```bash
# Regenerate Firebase options
flutterfire configure
```

### Issue: Build fails
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Issue: Emulator not found
```bash
# List available emulators
flutter emulators

# Launch specific emulator
flutter emulators --launch <emulator_id>
```

### Issue: Hot reload not working
```bash
# Stop app and restart
# Press 'r' in terminal for hot reload
# Press 'R' for hot restart
# Press 'q' to quit
```

## IDE Setup

### VS Code Extensions
- Flutter
- Dart
- Error Lens
- Bracket Pair Colorizer

### Android Studio Plugins
- Flutter
- Dart

## Useful Commands

```bash
# Run with hot reload
flutter run

# Build APK
flutter build apk

# Run tests
flutter test

# Format code
flutter format .

# Analyze code
flutter analyze

# Check for updates
flutter upgrade

# Clean build
flutter clean

# Get dependencies
flutter pub get

# Check doctor
flutter doctor -v
```

## Development Tips

### Hot Reload (r)
- Changes to most Dart code
- Widget modifications
- Color/style changes

### Hot Restart (R)
- Changes to main()
- Changes to initState()
- Enum changes

### Full Restart
- Changes to native code (Android/iOS)
- Changes to pubspec.yaml
- Asset additions

## Project Structure Quick Reference

```
lib/
├── main.dart                 # Entry point - START HERE
├── models/                   # Data structures
│   ├── user_model.dart      # User/Student/Alumni
│   ├── chat_model.dart      # Chat & messages
│   └── notification_model.dart
├── providers/                # App state
│   ├── auth_provider.dart   # Authentication
│   ├── user_provider.dart   # User management
│   ├── chat_provider.dart   # Messaging
│   └── notification_provider.dart
├── screens/                  # UI pages
│   ├── student/             # Student screens
│   ├── alumni/              # Alumni screens
│   └── cdc/                 # CDC screens
└── widgets/                  # Reusable components
```

## Next Steps

1. **Read Full Documentation**
   - [README.md](README.md) - Complete overview
   - [SETUP_GUIDE.md](SETUP_GUIDE.md) - Detailed setup
   - [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute

2. **Customize the App**
   - Change app icon
   - Modify colors in `lib/utils/theme.dart`
   - Add your university logo

3. **Deploy**
   - Set up production Firebase project
   - Update Firestore security rules
   - Build release version
   - Deploy to stores

4. **Add Features**
   - Video calling
   - AI resume builder
   - Event calendar
   - Analytics dashboard

## Getting Help

### Resources
- Flutter Docs: https://flutter.dev/docs
- Firebase Docs: https://firebase.google.com/docs
- Stack Overflow: Tag [flutter] [firebase]

### Community
- GitHub Issues: Report bugs
- Discord: Join dev community
- Email: dev@modyalumni.com

## Success Checklist

- [ ] App runs without errors
- [ ] Can create student account
- [ ] Can create alumni account
- [ ] Can see alumni profiles
- [ ] Can send messages
- [ ] Can post notifications (as CDC)
- [ ] Firebase console shows data

## Congratulations! 🎉

You now have Mody Alumni Connect running locally!

**What's Next?**
- Explore the codebase
- Try adding a new feature
- Report any bugs you find
- Share your feedback

Happy Coding! 🚀
