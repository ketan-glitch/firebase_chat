import 'package:firebase_chat/screens/authenticate/otp_verify.dart';
import 'package:firebase_chat/services/auth.dart';
import 'package:flutter/material.dart';
class SignInWithOtp extends StatefulWidget {
  @override
  _SignInWithOtpState createState() => _SignInWithOtpState();
}

class _SignInWithOtpState extends State<SignInWithOtp> {
  TextEditingController phoneEditingController;
  AuthService _authService = AuthService();
  String _phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text('Sign In With Mobile Number OTP'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: phoneEditingController,
                onChanged: (String text)=> _phone='+91$text',
                autofocus: true,

                style: TextStyle(fontSize: 20,),
                keyboardType: TextInputType.phone,
                // maxLength: 10,
                cursorColor: Colors.black54,
                cursorHeight: 25,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber[400],
                        width: 4,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber[400],
                      width: 4,
                    )
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber[400],
                        width: 4,
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              MaterialButton(
                // height: 50,
                // minWidth: 200,
                color: Colors.amber,
                onPressed: (){
                  // _authService.loginUser(phoneEditingController.text, context);
                  // loginOtp(_phone);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => VerifyOtp())
                  );
                },
                child: Text(
                  'Send Otp',
                  style: TextStyle(
                    color: Colors.black,
                    // fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
