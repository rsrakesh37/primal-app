import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Twitter API keys - These should be configured in your Twitter Developer Console
  static const String _twitterApiKey = 'YOUR_TWITTER_API_KEY';
  static const String _twitterApiSecret = 'YOUR_TWITTER_API_SECRET';
  static const String _twitterRedirectUri = 'primalbalance://';

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isSignedIn => currentUser != null;

  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      // Store user info securely
      await _storeUserInfo(userCredential.user);
      
      return userCredential;
    } catch (e) {
      print('Google Sign-In Error: $e');
      throw Exception('Google Sign-In failed: $e');
    }
  }

  // Facebook Login
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status != LoginStatus.success) {
        throw Exception('Facebook login failed: ${loginResult.message}');
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = 
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Sign in to Firebase with the Facebook credential
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      
      // Store user info securely
      await _storeUserInfo(userCredential.user);
      
      return userCredential;
    } catch (e) {
      print('Facebook Sign-In Error: $e');
      throw Exception('Facebook Sign-In failed: $e');
    }
  }

  // Twitter Login
  Future<UserCredential?> signInWithTwitter() async {
    try {
      // Create a TwitterLogin instance
      final twitterLogin = TwitterLogin(
        apiKey: _twitterApiKey,
        apiSecretKey: _twitterApiSecret,
        redirectURI: _twitterRedirectUri,
      );

      // Trigger the sign-in flow
      final authResult = await twitterLogin.login();

      if (authResult.status != TwitterLoginStatus.loggedIn) {
        throw Exception('Twitter login failed: ${authResult.errorMessage}');
      }

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Sign in to Firebase with the Twitter credential
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(twitterAuthCredential);
      
      // Store user info securely
      await _storeUserInfo(userCredential.user);
      
      return userCredential;
    } catch (e) {
      print('Twitter Sign-In Error: $e');
      throw Exception('Twitter Sign-In failed: $e');
    }
  }

  // Email/Password Sign Up
  Future<UserCredential?> signUpWithEmail(String email, String password, String displayName) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name
      await userCredential.user?.updateDisplayName(displayName);
      
      // Store user info securely
      await _storeUserInfo(userCredential.user);
      
      return userCredential;
    } catch (e) {
      print('Email Sign-Up Error: $e');
      throw Exception('Email Sign-Up failed: $e');
    }
  }

  // Email/Password Sign In
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Store user info securely
      await _storeUserInfo(userCredential.user);
      
      return userCredential;
    } catch (e) {
      print('Email Sign-In Error: $e');
      throw Exception('Email Sign-In failed: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      // Sign out from all providers
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        FacebookAuth.instance.logOut(),
      ]);
      
      // Clear stored user info
      await _secureStorage.deleteAll();
    } catch (e) {
      print('Sign Out Error: $e');
      throw Exception('Sign Out failed: $e');
    }
  }

  // Store user information securely
  Future<void> _storeUserInfo(User? user) async {
    if (user != null) {
      await _secureStorage.write(key: 'user_id', value: user.uid);
      await _secureStorage.write(key: 'user_email', value: user.email ?? '');
      await _secureStorage.write(key: 'user_name', value: user.displayName ?? '');
      await _secureStorage.write(key: 'user_photo', value: user.photoURL ?? '');
    }
  }

  // Get stored user info
  Future<Map<String, String?>> getStoredUserInfo() async {
    return {
      'user_id': await _secureStorage.read(key: 'user_id'),
      'user_email': await _secureStorage.read(key: 'user_email'),
      'user_name': await _secureStorage.read(key: 'user_name'),
      'user_photo': await _secureStorage.read(key: 'user_photo'),
    };
  }

  // Password Reset
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Password Reset Error: $e');
      throw Exception('Password Reset failed: $e');
    }
  }

  // Delete Account
  Future<void> deleteAccount() async {
    try {
      await currentUser?.delete();
      await _secureStorage.deleteAll();
    } catch (e) {
      print('Delete Account Error: $e');
      throw Exception('Delete Account failed: $e');
    }
  }
}