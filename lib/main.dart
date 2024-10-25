// import 'package:compu_movil_3/firebase/providers/product_provider.dart';
import 'package:compu_movil_3/presentation/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:compu_movil_3/config/routes/app_routes.dart';
import 'package:compu_movil_3/config/theme/app_theme.dart';
import 'package:compu_movil_3/firebase/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp()
    // const ProviderState()
  );
}
// class ProviderState extends StatelessWidget {
//   const ProviderState({super.key});


// @override
// Widget build(BuildContext context) {
//   return MultiProvider(providers: [
//     ChangeNotifierProvider(create: (_)=>ProductoProvider(),
//     lazy: false,
//     )
//     ],
//     child: const MyApp(),
//     );
//   }
// }
   
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SessionProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: AppTheme().getTheme(),
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
        initialRoute: '/home',
        onGenerateRoute: appRoutes.onGenerateRoute,
      ),
    );
  }
}

extension on Map<String, Widget Function(BuildContext p1)> {
  get onGenerateRoute => null;
}
