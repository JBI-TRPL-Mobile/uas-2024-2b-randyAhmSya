// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feature/auth/provider/auth_provider.dart';
import 'feature/auth/screen/login/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Welcome(
                title: 'test',
              ),
        },
      ),
    );
  }
}
