import 'package:compu_movil_3/config/routes/app_routes.dart';
import 'package:compu_movil_3/firebase/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  final void Function() goToRegister;

  const LoginScreen({
    super.key,
    required this.goToRegister,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme.surfaceContainer;

    return Center(
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              const Text('Iniciar Sesion ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const LoginForm(),

              const Divider(),
              const SizedBox(height: 10),

              const GoogleLogInButton(),

              const SizedBox(height: 70),

              Flex(
                direction: Axis.horizontal, 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿tienes una cuenta?'),
                  TextButton(
                    onPressed: goToRegister,
                    child: const Text('¡Registrate!'),
                  ),

                ]
              )
            ]
          ),
        ),
      )
    );
  }
}



class GoogleLogInButton extends StatelessWidget {
  const GoogleLogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.primary;

    final sessionProvider = context.watch<SessionProvider>();

    return ElevatedButton(
      onPressed: () async {
        await sessionProvider.loginWithGoogle();

        if( sessionProvider.session.isLogged == false ) {
          // TODO: Mostrar mensaje de error
        } else {
          navigateBack( context );
        }
      },
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2, color: borderColor),
      ),
      child: const Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.g_mobiledata),
          Text('Iniciar con Google'),
        ],
      ),
    );
  }
}



class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  // Estado que maneja el error de la validacion
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {

    final sessionProvider = context.watch<SessionProvider>();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Ingresa tu email',
              border: OutlineInputBorder()
            )
          ),

          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              hintText: 'Ingresa tu contraseña',
              border: OutlineInputBorder()
            )
          ),

          const SizedBox(height: 20),

          if ( _hasError )
            const Text('No fue posible inicar sesión',
              style: TextStyle(
                color: Color.fromARGB(255, 213, 214, 197),
              ),
            ),

          ElevatedButton(
            onPressed: () async {
              // Valida el formulario
              final isValid = _formKey.currentState!.validate();
              if( isValid ) {
                String email = emailController.text;
                String password = passwordController.text;

                await sessionProvider.loginWithCredentials( email, password );

                if( sessionProvider.session.isLogged == false ) {
                  setState(() {
                    _hasError = true;
                  });
                } else {
                  navigateBack( context );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              fixedSize: const Size.fromWidth( 200 ),
            ),
            child: const Text('Log In'),
          ),
          const SizedBox(height: 10),
        ]
      )
    );
  }
}