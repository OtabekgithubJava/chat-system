import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsup/Pages/home_page.dart';
import 'package:whatsup/Pages/login_page.dart';
import 'package:whatsup/Pages/register_page.dart';
import 'package:whatsup/Themes/dark_mode.dart';
import 'package:whatsup/Themes/light_mode.dart';
import 'package:whatsup/Themes/theme_provider.dart';
import 'package:whatsup/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const RegisterPage(),
          theme: Provider.of<ThemeProvider>(context).themeData,
        ),
      ),
    );
  }
}
