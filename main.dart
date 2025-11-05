import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/notification_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/student/student_home_screen.dart';
import 'screens/alumni/alumni_home_screen.dart';
import 'screens/cdc/cdc_home_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp()); // NO const here because Firebase initialization is async
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // your provider
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: GetMaterialApp(
        title: 'Mody Alumni Connect',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: SplashScreen(), // SplashScreen should handle auth redirection
        getPages: [
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignupScreen()),
          GetPage(name: '/student-home', page: () => StudentHomeScreen()),
          GetPage(name: '/alumni-home', page: () => AlumniHomeScreen()),
          GetPage(name: '/cdc-home', page: () => CdcHomeScreen()),
        ],
      ),
    );
  }
}

