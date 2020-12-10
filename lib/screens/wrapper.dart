import 'package:firebase_chat/models/user.dart';
import 'package:firebase_chat/screens/authenticate/authenticate.dart';
import 'package:firebase_chat/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // print(user);
    // return Home() or Authenticate()
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
