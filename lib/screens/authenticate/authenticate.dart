import 'package:firebase_chat/screens/authenticate/signin_email_pass.dart';
import 'package:firebase_chat/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleView(){
    setState(() {
      showSignIn =! showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignInWithEmailPassword(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}
