import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'theme/streamflix_theme.dart';
import 'theme/route_transitions.dart';

void main() {
  runApp(const StreamflixCloneApp());
}

class StreamflixCloneApp extends StatelessWidget {
  const StreamflixCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streamflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: StreamflixColors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: StreamflixColors.primary,
          brightness: Brightness.dark,
          primary: StreamflixColors.primary,
          secondary: StreamflixColors.secondary,
        ),
        fontFamily: GoogleFonts.rajdhani().fontFamily,
      ),
      // Every screen is registered as a named route, as required by
      // the lab: "Define all screens as named routes in your
      // MaterialApp (e.g., using the routes property or
      // onGenerateRoute)." Each route is wrapped in streamflixFadeRoute so
      // every screen-to-screen transition gets the same simple
      // fade + slide-up animation.
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return streamflixFadeRoute(const SplashScreen(), settings);
          case '/login':
            return streamflixFadeRoute(const LoginScreen(), settings);
          case '/signup':
            return streamflixFadeRoute(const SignUpScreen(), settings);
          case '/home':
            return streamflixFadeRoute(const HomeScreen(), settings);
          default:
            return streamflixFadeRoute(const LoginScreen(), settings);
        }
      },
    );
  }
}
