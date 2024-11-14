import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Tratar erros específicos do Firebase Auth
      throw Exception("Erro ao fazer login: ${e.message}");
    } catch (e) {
      // Tratar outros tipos de exceções
      throw Exception("Erro desconhecido ao fazer login: $e");
    }
  }

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Tratar erros específicos do Firebase Auth
      throw Exception("Erro ao criar conta: ${e.message}");
    } catch (e) {
      // Tratar outros tipos de exceções
      throw Exception("Erro desconhecido ao criar conta: $e");
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Erro ao sair: $e");
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
