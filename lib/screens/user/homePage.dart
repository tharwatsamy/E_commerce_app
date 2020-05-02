import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/auth.dart';
class HomePage extends StatefulWidget {
  static String id='HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final _auth=Auth();
   FirebaseUser _loggedUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  void initState() {
     getCurrenUser();
  }


  getCurrenUser()async
  {
    _loggedUser = await _auth.getUser();
  }
}
