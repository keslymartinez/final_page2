import 'package:compu_movil_3/config/routes/app_routes.dart';
import 'package:compu_movil_3/firebase/entities/session_entity.dart';
import 'package:compu_movil_3/firebase/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserStatus extends StatelessWidget {
  const UserStatus({super.key});


  @override
  Widget build(BuildContext context) {
    final sessionProvider = context.watch<SessionProvider>();
    final backgroundColor = Theme.of(context).colorScheme.onSecondary;
    
    return Container(
      width: 200,
      height: 100,
      // Aplica border redondeados
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ( sessionProvider.session.isLogged == false )
              ? const _NoSessionMenu()
              : _SessionMenu(
                  session: sessionProvider.session,
                  onLogout: sessionProvider.logout,
                ),
          ],
        ),
      ),
    );
  }
}


class _SessionMenu extends StatelessWidget {

  final SessionEntity session;
  final void Function() onLogout;

  const _SessionMenu({
    required this.session,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {

    final fontColor = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        Text('Hola, ${session.username}!',
          style: TextStyle(
            color: fontColor,
          ),
        ),
        Divider(color: fontColor, indent: 10, endIndent: 10, thickness: 0.5,),
        ElevatedButton(
          onPressed: () {
            onLogout();
          },
          child: const Text('Cerrar Sesión'),
        ),
      ]
    );
  }
}



class _NoSessionMenu extends StatelessWidget {
  const _NoSessionMenu();

  @override
  Widget build(BuildContext context) {

    final fontColor = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        Text('No has iniciado sesion',
          style: TextStyle(
            color: fontColor,
          ),
        ),
        Divider(color: fontColor, indent: 10, endIndent: 10, thickness: 0.5,),
        ElevatedButton(
          onPressed: () {
            navigateTo( context, AppRoutes.auth );
          },
          child: const Text('Iniciar sesión'),
        ),
      ]
    );
  }
}