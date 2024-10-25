import 'package:compu_movil_3/config/routes/app_routes.dart';
import 'package:compu_movil_3/firebase/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {

  final void Function() goToLogin;

  const RegisterScreen({
    super.key,
    required this.goToLogin,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme.surfaceContainer;

    return Center(
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              const Text('Registrarse',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const RegisterForm(),

              const Divider(),
              const SizedBox(height: 10),

              const GoogleSignUpButton(),

              const SizedBox(height: 70),

              Flex(
                direction: Axis.horizontal, 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya tienes una cuenta?'),
                  TextButton(
                    onPressed: goToLogin,
                    child: const Text('¡Inicia Sesion!'),
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


class GoogleSignUpButton extends StatelessWidget {
  const GoogleSignUpButton({
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
          Text('Registrarse con Google'),
        ],
      ),
    );
  }
}



class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formKey = GlobalKey<FormState>();

  bool _hasError = false;

  @override
  Widget build(BuildContext context) {

    // Obtiene el session provider
    final sessionProvider = context.watch<SessionProvider>();

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Nombre de usuario',
              hintText: 'Ingresa tu nombre de usuario',
              border: OutlineInputBorder()
            )
          ),

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
            const Text('No fue posible crear una cuenta',
              style: TextStyle(
                color: Color.fromARGB(255, 245, 236, 235),
              ),
            ),

          ElevatedButton(
            onPressed: () async {
              // Valida el formulario
              final isValid = _formKey.currentState!.validate();
              if( isValid ) {
                String username = usernameController.text;
                String email = emailController.text;
                String password = passwordController.text;

                await sessionProvider.signUpWithCredentials( email, password, username );

                if ( sessionProvider.session.isLogged == false){
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
            child: const Text('Sign Up'),
          ),
          const SizedBox(height: 10),
        ]
      )
      )
    );
  }
}