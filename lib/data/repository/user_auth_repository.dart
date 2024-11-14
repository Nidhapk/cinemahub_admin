// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_alertbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthRepository {
  final FirebaseAuth firebase = FirebaseAuth.instance;

  sigin(String email, String password) async {
    await firebase.signInWithEmailAndPassword(email: email, password: password);
  }

  signUp(String email, String password) async {
    try {
      await firebase.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> sendVerificationLink() async {
    User? user = firebase.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (_) {
        rethrow;
      }
    } else {}
  }

  Future<void> checkVerified(BuildContext context, User user) async {
    await user.reload();
    User? refreshedUser = FirebaseAuth.instance.currentUser;

    if (refreshedUser != null && refreshedUser.emailVerified) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/splash', (route) => false);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertBox(
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: 'Email not verified',
              content: 'Please verify your email before proceeding.',
              confirmText: 'Ok');
        },
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final googleAuth = await googleUser.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      return await firebase.signInWithCredential(cred);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  // Future<void> sendResetPasswordLink(String email) async {
  //   try {
  //     await firebase.sendPasswordResetEmail(email: email);
  //   } on FirebaseAuthException catch (_) {
  //     rethrow;
  //   }
  // }
  Future<void> updateAdminPassword(String newPassword) async {
    final adminCollection = FirebaseFirestore.instance.collection('admin');

    // Fetch the first document in the 'admin' collection
    final querySnapshot = await adminCollection.limit(1).get();

    // Check if any document exists in the collection
    if (querySnapshot.docs.isNotEmpty) {
      // Get the document ID of the first document
      final docId = querySnapshot.docs.first.id;

      // Update the password field of the first document
      await adminCollection.doc(docId).update({'password': newPassword});
      log('Password updated successfully');
    } else {
      log('No document found in the admin collection.');
    }
  }

  signOut() async {
    try {
      await firebase.signOut();
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<bool> loginAdmin(String username, String password) async {
    final adminCollection = FirebaseFirestore.instance.collection('admin');

    final query = await adminCollection
        .where('userName', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();

    if (query.docs.isNotEmpty) {
      // Save login status in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username); // Optional: store username

      return true; // Login successful
    } else {
      return false; // Login failed
    }
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<bool> checkAdminExists() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('admin').limit(1).get();
    log('admin: $snapshot');
    log('${snapshot.docs.isNotEmpty}');
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> checkSecurityCode(String code) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('admin')
        .where('securitycode', isEqualTo: code)
        .get();
    return docSnapshot.docs.isNotEmpty;
  }

  Future<bool> verifyAdminPassword(String enteredPassword) async {
    try {
      // Get the first document in the 'admin' collection
      final snapshot =
          await FirebaseFirestore.instance.collection('admin').limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        // Retrieve the password from the first document
        final storedPassword = snapshot.docs.first.get('password');
        // Compare the stored password with the entered password
        return storedPassword == enteredPassword;
      } else {
        // No documents found in the 'admin' collection
        return false;
      }
    } on FirebaseException catch (e) {
      print('Error fetching password: $e');
      rethrow;
    
    }
  }
}
