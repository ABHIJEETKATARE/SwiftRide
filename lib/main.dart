import 'package:flutter/material.dart';
import 'package:internshala_assignment/features/auth/screens/auth_screen.dart';
import 'package:internshala_assignment/features/auth/services/auth_service.dart';
import 'package:internshala_assignment/features/home/screens/home_screen.dart';
import 'package:internshala_assignment/on_generate_routes.dart';
import 'package:internshala_assignment/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getToken(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      title: 'Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? const AuthScreen()
          : const HomeScreen(),
    );
  }
}
