import 'package:firebase_chat/otp/main.dart';
import 'package:firebase_chat/screens/authenticate/signin_email_pass.dart';
import 'package:firebase_chat/screens/authenticate/signin_otp.dart';
import 'package:firebase_chat/screens/home/home.dart';
import 'package:firebase_chat/screens/wrapper.dart';
import 'package:firebase_chat/services/auth.dart';
import 'package:firebase_chat/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _authService = AuthService();

  bool loading= false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() :Scaffold(
      backgroundColor: Colors.amber[100],
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40,left: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'SignIn \nto \nChat',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 50,),
            MaterialButton(
              minWidth: 200,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Wrapper())
                );
              },
              color: Colors.amber,
              child: Text(
                  'Sign In Using Email-Id'
              ),
            ),
            SizedBox(height: 10,),
            MaterialButton(
              minWidth: 200,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => App())
                );
              },
              color: Colors.amber,
              child: Text(
                  'Sign In Using Mobile OTP'
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 200,
              child: RaisedButton.icon(
                // height: 50,
                // minWidth: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () async{
                  dynamic result = await _authService.signInWithGoogle().then((result) {
                    if(result!=null){
                      loading=true;
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => Home())
                      );
                    }
                  });
                },
                color: Colors.amber,
                icon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    'assets/images/google-icon.svg',
                    height: 30,
                  ),
                ),
                label: Text('Google SignIn'),
                // icon: Icon(Icons.person),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
