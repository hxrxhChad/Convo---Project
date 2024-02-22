import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

class SettingService {
  Stream<List<AuthModel>> getAuthModel() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('authId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // Convert each document snapshot to AuthModel instance
              return AuthModel.fromJson(doc.data());
            }).toList());
  }

  Stream<List<SettingModel>> getSettingModel() {
    return FirebaseFirestore.instance
        .collection('setting')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // Convert each document snapshot to AuthModel instance
              return SettingModel.fromJson(doc.data());
            }).toList());
  }

  Future<void> updateUserProfile({
    required String authId,
    required String username,
    required String photoUrl,
    required String name,
  }) async {
    try {
      // Construct the data to update
      Map<String, dynamic> userData = {};
      userData['username'] = username;
      userData['photoUrl'] = photoUrl;
      userData['name'] = name;

      // Update the user profile in the users collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authId)
          .update(userData);
    } catch (error) {
      // Handle any errors that occur during the update process
      debugPrint('Error updating user profile: $error');
    }
  }
}
