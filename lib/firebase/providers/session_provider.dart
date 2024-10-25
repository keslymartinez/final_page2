import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:compu_movil_3/firebase/entities/session_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';



class SessionProvider extends ChangeNotifier {

  SessionEntity session = SessionEntity(
    isLogged: false,
  );

  SessionProvider() {
    // Listener que notificará a los widgets cuando cambie el estado de la sesión
    FirebaseAuth.instance
      .authStateChanges()
      .listen(( User? user ) {
        if (user == null) {
          session = SessionEntity( isLogged: false);
        } else {
          session = SessionEntity(
            isLogged: true,
            email: user.email ?? '',
            username: user.displayName ?? '',
            imageUrl: user.photoURL ?? '',
            id: user.uid
          );
        }

        notifyListeners();
      });
  }


  // Permite iniciar sesión con email + password
  Future<void> loginWithCredentials( emailAddress, password ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      final user = credential.user;
      session = SessionEntity(
        isLogged: true,
        email: emailAddress,
        username: user!.displayName ?? '',
        imageUrl: user.photoURL ?? '',
        id: user.uid
      );

    } catch (e) {

    }
  }


  // Permite registrar un nuevo usuario con email + password + username
  Future<void> signUpWithCredentials( String emailAddress, String password, String username ) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      User? user = credential.user;

      if( user != null ) {
        await user.updateProfile(displayName: username);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        session = SessionEntity(
          isLogged: true,
          email: emailAddress,
          username: username,
          imageUrl: user!.photoURL ?? '',
          id: user.uid
        );
      }
    } catch (e) {

    }
  }
  

  // Permite iniciar sesión con Google
  Future<void> loginWithGoogle() async {
    try {
      // Inicia el proceso de autenticación con Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = await FirebaseAuth.instance.signInWithCredential( credential );

      session = SessionEntity(
        isLogged: true,
        email: user.user!.email ?? '',
        username: user.user!.displayName ?? '',
        imageUrl: user.user!.photoURL ?? '',
        id: user.user!.uid
      );

    } catch (e) {
 
    }
  }


  // Cierra la sesión
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  // Función crea una session false para hacer pruebas
  void fakeLogin() {
    session = SessionEntity(
      isLogged: true,
      email: 'mail@example.com',
      username: 'johndoe',
      imageUrl: '',
      id: '1'
    );
  }


}