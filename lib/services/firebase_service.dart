import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagle_eye/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/hostels.dart';
import '../model/user_model.dart';
import '../screens/login_screen.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // the login with Email firebase function
  Future login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // the signup with Email firebase function
  Future signup(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // save user details to FirestoreDatabase function
  Future postUserDetails(BuildContext context, String firstName,
      String lastName, String email) async {
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstName;
    userModel.lastName = lastName;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  // the userDetails from firebase function
  Future<UserModel> getUserDetails() async {
    UserModel userModel = UserModel();
    User? user = auth.currentUser;
    firebaseFirestore.collection("users").doc(user!.uid).get().then((value) {
      userModel = UserModel.fromMap(value.data());
    });
    return userModel;
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  static Stream<List<Hostels>> allhostels() => FirebaseFirestore.instance
      .collection('hostels')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Hostels.fromJson(doc.data())).toList());
}
