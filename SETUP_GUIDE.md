# Setup Guide - Mody Alumni Connect

This guide will walk you through setting up the Mody Alumni Connect application from scratch.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Flutter Setup](#flutter-setup)
3. [Firebase Configuration](#firebase-configuration)
4. [Project Setup](#project-setup)
5. [Running the App](#running-the-app)
6. [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software
- **Operating System**: Windows 10/11, macOS 10.14+, or Linux
- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Comes bundled with Flutter
- **Git**: For version control
- **IDE**: VS Code or Android Studio

### For Android Development
- Android Studio
- Android SDK (API level 21 or higher)
- Android Emulator or physical device

### For iOS Development (macOS only)
- Xcode 13 or higher
- CocoaPods
- iOS Simulator or physical device

## Flutter Setup

### 1. Install Flutter

#### Windows
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract to C:\src\flutter
# Add to PATH: C:\src\flutter\bin

# Verify installation
flutter doctor
```

#### macOS
```bash
# Using Git
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH in ~/.zshrc or ~/.bash_profile
export PATH="$PATH:`pwd`/flutter/bin"

# Reload shell
source ~/.zshrc

# Verify installation
flutter doctor
```

#### Linux
```bash
# Download and extract Flutter
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.x.x-stable.tar.xz
tar xf flutter_linux_3.x.x-stable.tar.xz

# Add to PATH in ~/.bashrc
export PATH="$PATH:/home/user/development/flutter/bin"

# Reload shell
source ~/.bashrc

# Verify installation
flutter doctor
```

### 2. Configure Flutter

```bash
# Accept Android licenses (if using Android)
flutter doctor --android-licenses

# Check for any issues
flutter doctor -v
```

## Firebase Configuration

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name: `mody-alumni-connect`
4. Disable Google Analytics (or enable if you want analytics)
5. Click "Create Project"

### 2. Register Your Apps

#### Android App
1. In Firebase Console, click "Add app" → Android
2. Package name: `com.mody.alumni.connect`
3. App nickname: `Mody Alumni Connect Android`
4. Download `google-services.json`
5. Place in `android/app/` directory

#### iOS App
1. In Firebase Console, click "Add app" → iOS
2. Bundle ID: `com.mody.alumni.connect`
3. App nickname: `Mody Alumni Connect iOS`
4. Download `GoogleService-Info.plist`
5. Place in `ios/Runner/` directory

### 3. Install FlutterFire CLI

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Add to PATH if needed
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### 4. Configure FlutterFire

```bash
# Navigate to project directory
cd mody-alumni-connect

# Configure FlutterFire
flutterfire configure

# Select your Firebase project
# Select platforms (Android, iOS, Web)
# This will generate lib/firebase_options.dart
```

### 5. Enable Firebase Services

#### Authentication
1. Go to Firebase Console → Authentication
2. Click "Get Started"
3. Enable "Email/Password" sign-in method
4. Click "Save"

#### Cloud Firestore
1. Go to Firebase Console → Firestore Database
2. Click "Create Database"
3. Start in **Test Mode** (change to production rules later)
4. Choose location closest to your users
5. Click "Enable"

#### Cloud Messaging
1. Go to Firebase Console → Cloud Messaging
2. No additional setup required for basic notifications
3. For iOS: Upload APNs certificates (see iOS setup below)

#### Storage
1. Go to Firebase Console → Storage
2. Click "Get Started"
3. Start in **Test Mode**
4. Click "Done"

### 6. Configure Firestore Security Rules

In Firebase Console → Firestore → Rules, paste the following:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper functions
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    function hasRole(role) {
      return isSignedIn() && 
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == role;
    }
    
    // Users collection
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn();
      allow update: if isOwner(userId);
      allow delete: if false; // Prevent deletion
    }
    
    // Chat rooms
    match /chatRooms/{chatRoomId} {
      allow read: if isSignedIn() && 
        request.auth.uid in resource.data.participants;
      allow create: if isSignedIn();
      allow update: if isSignedIn() && 
        request.auth.uid in resource.data.participants;
      
      match /messages/{messageId} {
        allow read: if isSignedIn();
        allow create: if isSignedIn();
      }
    }
    
    // Notifications
    match /notifications/{notificationId} {
      allow read: if isSignedIn();
      allow create: if hasRole('cdc');
      allow update: if hasRole('cdc');
      allow delete: if hasRole('cdc');
    }
    
    // User notifications
    match /userNotifications/{userNotifId} {
      allow read: if isSignedIn() && 
        isOwner(resource.data.userId);
      allow write: if isSignedIn();
    }
    
    // Mentorship requests
    match /mentorshipRequests/{requestId} {
      allow read: if isSignedIn() && 
        (request.auth.uid == resource.data.studentId || 
         request.auth.uid == resource.data.alumniId);
      allow create: if isSignedIn() && hasRole('student');
      allow update: if isSignedIn() && 
        request.auth.uid == resource.data.alumniId;
    }
  }
}
```

Click "Publish" to apply the rules.

## Project Setup

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/mody-alumni-connect.git
cd mody-alumni-connect
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Create Assets Directories

```bash
# Create asset directories
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/fonts
```

### 4. Download Poppins Font

1. Download Poppins font from [Google Fonts](https://fonts.google.com/specimen/Poppins)
2. Extract and place in `assets/fonts/`:
   - Poppins-Regular.ttf
   - Poppins-Medium.ttf
   - Poppins-SemiBold.ttf
   - Poppins-Bold.ttf

## Android Specific Setup

### 1. Update AndroidManifest.xml

File: `android/app/src/main/AndroidManifest.xml`

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    
    <application
        android:label="Mody Alumni"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        
        <!-- Add this for notifications -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_channel_id"
            android:value="mody_alumni_channel" />
            
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
              
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
```

### 2. Update build.gradle

File: `android/app/build.gradle`

```gradle
android {
    namespace "com.mody.alumni.connect"
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.mody.alumni.connect"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
        multiDexEnabled true
    }
}

dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
}
```

## iOS Specific Setup (macOS only)

### 1. Install Pods

```bash
cd ios
pod install
cd ..
```

### 2. Configure Push Notifications

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Runner project → Signing & Capabilities
3. Add capability: "Push Notifications"
4. Add capability: "Background Modes" → check "Remote notifications"

### 3. Update Info.plist

File: `ios/Runner/Info.plist`

Add permissions:

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to upload profile pictures</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access to upload images</string>
```

## Running the App

### Check Available Devices

```bash
flutter devices
```

### Run in Debug Mode

```bash
# Run on connected device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run with hot reload
flutter run --hot
```

### Build for Release

#### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### Android App Bundle
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

#### iOS
```bash
flutter build ios --release
# Open in Xcode to archive and upload
```

## Testing

### Create Test Accounts

Create test accounts for each user role:

1. **Student Account**
   - Email: student@test.com
   - Password: test123
   - Department: Engineering
   - Enrollment: EN2024001

2. **Alumni Account**
   - Email: alumni@test.com
   - Password: test123
   - Department: Engineering
   - Graduation Year: 2020

3. **CDC Account**
   - Email: cdc@test.com
   - Password: test123

### Test Scenarios

1. **Authentication Flow**
   - Sign up as student
   - Sign in with created account
   - Password reset

2. **Student Features**
   - Browse alumni
   - Filter by department
   - Bookmark alumni
   - Send mentorship request
   - Chat with alumni

3. **Alumni Features**
   - Complete profile
   - Toggle availability
   - Review requests
   - Accept/decline requests
   - Chat with students

4. **CDC Features**
   - Post opportunity
   - Post event
   - Pin notification
   - Target specific audience

## Troubleshooting

### Common Issues

#### 1. Firebase not initialized
```
Solution: Ensure firebase_options.dart is generated and Firebase.initializeApp() is called
```

#### 2. Google Services error
```
Solution: Verify google-services.json (Android) or GoogleService-Info.plist (iOS) is in correct location
```

#### 3. Build failures
```bash
# Clean build
flutter clean
flutter pub get

# Rebuild
flutter run
```

#### 4. Firestore permission denied
```
Solution: Check Firestore security rules and ensure user is authenticated
```

#### 5. iOS pod install issues
```bash
cd ios
rm Podfile.lock
rm -rf Pods
pod install --repo-update
cd ..
```

### Getting Help

- Check [Flutter Documentation](https://flutter.dev/docs)
- Visit [Firebase Documentation](https://firebase.google.com/docs)
- Open an issue on GitHub
- Contact team: support@modyalumni.com

## Next Steps

1. Customize app branding (logo, colors)
2. Add app icon using flutter_launcher_icons
3. Configure app splash screen
4. Set up CI/CD pipeline
5. Deploy to Google Play Store and App Store
6. Set up analytics and crash reporting
7. Implement remaining features (AI resume builder, etc.)

---

**Happy Coding! 🚀**
