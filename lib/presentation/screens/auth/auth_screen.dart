import 'package:compu_movil_3/presentation/screens/auth/login_screen.dart';
import 'package:compu_movil_3/presentation/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  // Estado para controlar la pantalla de autenticación. Login o registro
  Screens currentScreen = Screens.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresa a tu cuenta'),
      ),
      body: (currentScreen == Screens.login)
        ? LoginScreen( goToRegister: goToRegister )
        : RegisterScreen( goToLogin: goToLogin ),
    );
  }

  void goToLogin() {
    setState(() {
      currentScreen = Screens.login;
    });
  }

  void goToRegister() {
    setState(() {
      currentScreen = Screens.register;
    });
  }
}

enum Screens {
  login,
  register,
}