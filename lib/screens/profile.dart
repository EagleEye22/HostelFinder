import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagle_eye/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../widgets/ProfileWidget.dart';
import '../widgets/button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  UserModel loggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:
                "https://firebasestorage.googleapis.com/v0/b/eagleeye-5f99f.appspot.com/o/icons8-customer.png?alt=media&token=ca7aa784-e5b9-4650-93a4-2ff82eff5d81",
            onClicked: () {},
          ),
          const SizedBox(height: 24),
          buildName(loggedInUser),
          const SizedBox(height: 24),
          Center(child: buildLogoutButton(context)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

Widget buildName(UserModel user) => Column(
      children: [
        Text(
          "${user.firstName} ${user.lastName}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email.toString(),
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildLogoutButton(BuildContext context) => ButtonWidget(
      text: 'Log Out',
      onClicked: () {
        LogOut(context);
      },
    );
// ignore: non_constant_identifier_names
void LogOut(BuildContext context) async {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  await firebaseAuthService.logout(context);
}
