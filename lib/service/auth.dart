import 'package:chat_alpha_sept/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  String loginFormError(String email, String password) {
    if (email.isEmpty) {
      return "Email can't be empty";
    } else if (password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 8) {
      return "Password can't be less than 8 characters";
    } else {
      return 'null';
    }
  }

  String registerFormError(
      String username, String email, String password, String name) {
    if (username.isEmpty) {
      return "Username can't be empty";
    } else if (email.isEmpty) {
      return "Email can't be empty";
    } else if (password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 8) {
      return "Password can't be less than 8 characters";
    } else if (name.isEmpty) {
      return "Name can't be empty";
    } else {
      return 'null';
    }
  }

  Future<String?> login(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential.user?.uid;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<User?> register(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<void> registerCloud(String username, String email, String password,
      String name, int time) async {
    AuthModel user = AuthModel(
        username: username,
        email: email,
        password: password,
        name: name,
        time: time,
        gender: '',
        photo: '');

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    user.authId = userRef.id;
    final data = user.toJson();

    userRef.set(data);
  }
}
