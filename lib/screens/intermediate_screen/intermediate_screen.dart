import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../screens/Welcome/Welcome.dart';
import '../../screens/auth_screen/auth_screen.dart';
import '../../screens/loading_screen/loading_screen.dart';

class IntermediateScreen extends StatelessWidget {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();

  IntermediateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFirebaseSdk,
        builder: (_, snapshot) {
          final navContext = Navigator.of(context);
          if (snapshot.hasError) return const Scaffold();

          if (snapshot.connectionState == ConnectionState.done) {
            // Assign listener after the SDK is initialized successfully
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                navContext.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              } else {
                navContext.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
              }
            });
          }

          return const LoadingScreen();
        });
  }
}
