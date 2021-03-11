import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weight/View/Signin.dart';
import 'package:weight/View/home/homepage.dart';

class handleauth extends StatelessWidget {
  const handleauth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Waiting');
        } else {
          if (snapshot.hasData) {
            return Home();
          } else {
            return Signin();
          }
        }
      },
    );
  }
}
