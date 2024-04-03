import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/index.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        if (user != null && authResult.additionalUserInfo?.isNewUser == true) {
          String authId = user.uid;
          String username = user.email!.split('@').first;
          String email = user.email ?? '';
          String name = user.displayName ?? '';
          int time = DateTime.now().millisecondsSinceEpoch;
          String photo = user.photoURL ?? '';
          await registerCloud(authId, username, email, name, time, photo);
        }
        return user;
      }
      return null;
    } catch (error) {
      debugPrint("Error signing in with Google: $error");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      debugPrint('User signed out successfully');
    } catch (error) {
      debugPrint('Error signing out: $error');
    }
  }

  Future<void> updateUserInfo(
      {String? email, String? photo, String? name, String? username}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('EMauth');
      QuerySnapshot querySnapshot =
          await users.where('authId', isEqualTo: _auth.currentUser?.uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic> updatedData = {};
        if (email != null) updatedData['email'] = email;
        if (photo != null) updatedData['photo'] = photo;
        if (name != null) updatedData['name'] = name;
        if (username != null) updatedData['username'] = username;
        await userDoc.reference.update(updatedData);
        debugPrint('User information updated successfully!');
      } else {
        debugPrint('User not found with the provided authId.');
      }
    } catch (error) {
      debugPrint('Error updating user information: $error');
    }
  }

  Stream<List<AuthModel>> getAuthModel() {
    return FirebaseFirestore.instance
        .collection('EMauth')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return AuthModel.fromJson(doc.data());
            }).toList());
  }

  Future<void> registerCloud(String authId, String username, String email,
      String name, int time, String photo) async {
    AuthModel user = AuthModel(
        authId: authId,
        username: username,
        email: email,
        name: name,
        accountCreationTime: time,
        photo: photo);

    final userRef = FirebaseFirestore.instance
        .collection('EMauth')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    // user.authId = userRef.id;
    final data = user.toJson();

    userRef.set(data);
  }

  Stream<bool> getTaken(String username) {
    return FirebaseFirestore.instance
        .collection('EMauth')
        .where('username', isEqualTo: username)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.isNotEmpty);
  }
}
