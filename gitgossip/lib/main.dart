import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gitgossip/features/bottom_nav/controllers/nav_controller.dart';
import 'package:gitgossip/features/splashScreen/screens/splash_screen.dart';
import 'package:gitgossip/firebase_options.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitGossip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
