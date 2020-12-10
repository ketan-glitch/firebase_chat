import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/login.dart';
import 'package:firebase_chat/models/user.dart';
import 'package:firebase_chat/otp/main.dart';
import 'package:firebase_chat/screens/authenticate/basesignin.dart';
import 'package:firebase_chat/screens/wrapper.dart';
import 'package:firebase_chat/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Firebase Chat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SignIn(),
          // home: Login(),

          // // screens.home: Login(),
          // initialRoute: '/',
          // routes: {
          //   '/': (context)=> Login(),
          //   // '/dashboard':(context)=>Dashboard(),
          //   '/screens.authenticate':(context)=> Authenticate(),
          // },
        ),
  ));
}
