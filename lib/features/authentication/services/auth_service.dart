import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<String?> getUserCountry(String uid) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      return doc.get('country') as String?;
    } catch (e) {
      return null;
    }
  }

  Future<String> _getCountry() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      return placemarks.first.country ?? '';
    } catch (e) {
      return '';
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(
      User user, String name, String email, String role, String country) async {
    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'role': role,
      'country': country,
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
        final country = await _getCountry();
        await _createUserDocument(user, name, email, role, country);
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
          final country = await _getCountry();
          await _createUserDocument(user, user.displayName ?? '', user.email ?? '', 'customer', country);
        }
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  //Sign in with Facebook
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Check if the user is new
          final DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
          if (!doc.exists) {
            // New user, create document
            final country = await _getCountry();
            await _createUserDocument(user, user.displayName ?? '', user.email ?? '', 'customer', country);
          }
        }
        return user;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }


  // Password Reset
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Set user role (for new Google users)
  Future<void> setUserRole(User user, String role) async {
     final country = await _getCountry();
    await _createUserDocument(user, user.displayName ?? '', user.email ?? '', role, country);
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
