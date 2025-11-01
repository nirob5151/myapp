import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get user role
  Future<String?> getUserRole(String uid) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      return doc.get('role') as String?;
    } catch (e) {
      return null;
    }
  }

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'role': role,
        });
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
