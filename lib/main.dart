import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/firebase_options.dart';
import 'package:mistri_app/models/universal_model.dart';
import 'package:mistri_app/screens/splash_sceen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UniversalModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Onest',
      ),
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SplashSceen(),
    );
  }
}
