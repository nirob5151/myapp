import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  // Get current user
  User? get currentUser => _auth.currentUser;

  AuthService({FirebaseAuth? auth, FirebaseFirestore? firestore, GoogleSignIn? googleSignIn})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  // Get user role
  Future<String?> getUserRole(String uid) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      return doc.get('role') as String?;
    } catch (e) {
      return null;
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(
      User user, String name, String email, String role) async {
    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'role': role,
    });
  }

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
      String name, String email, String password, String role) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      if (user != null) {
        await _createUserDocument(user, name, email, role);
        await user.sendEmailVerification();
      }
      return user;
    } catch (e) {
      rethrow;
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
      rethrow;
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result = await _auth.signInWithCredential(credential);
      final User? user = result.user;

      if (user != null) {
        // Check if the user is new
        final DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        if (!doc.exists) {
          // New user, create document
          await _createUserDocument(user, user.displayName ?? '', user.email ?? '', 'customer');
        }
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Set user role (for new Google users)
  Future<void> setUserRole(User user, String role) async {
    await _createUserDocument(user, user.displayName ?? '', user.email ?? '', role);
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
