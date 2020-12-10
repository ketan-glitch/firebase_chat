import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  String verificationId;
  String _phone;
  String _otp;
  TextEditingController phoneEditingController = new TextEditingController();

  Future<UserCredential> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<bool> loginUser(String phone, BuildContext context) async{

    final PhoneCodeSent smsCodeSent = (String verId, [int forceResendingToken]){
      verificationId = verId;
    };
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          await _auth.signInWithCredential(credential).then((result) async {
            User user = result.user;
            // if(user != null){
            //   _showSnackBar();
            //   Navigator.push(context, MaterialPageRoute(
            //       builder: (context) => Dashboard(user)
            //   ));
            // }else{
            //   print("Error");
            // }
            if (user != null)  {

            }

          });


        },
        verificationFailed: (FirebaseAuthException exception){
          print(exception);
        },
        codeSent: smsCodeSent,
       codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
    return false;
  }

  void verifyOTP(String smsCode) async{
    var _authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    _auth
        .signInWithCredential(_authCredential)
        .then((UserCredential result) {
      User user = result.user;

      if (user != null) {

        userAuthorized();
      }
      // Navigator.push(context, MaterialPageRoute(
      //     // builder: (context) => Dashboard(user)
      // ));
      ///go To Next Page
    }).catchError((error) {
      Navigator.pop(context);
    });
  }
  userAuthorized() {
    print('can go to next page');
  }

  // void _signOut() {
  //   googleSignIn.signOut();
  //   print('User Signed Out');
  // }

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // _showSnackBar() {
  //   final snackBar = new SnackBar(
  //     content: Text("User LogedIn"),
  //     duration: Duration(
  //       seconds: 5,
  //     ),
  //   );
  //   _scaffoldKey.currentState.showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: phoneEditingController,
                onChanged: (String text)=> _phone=text,
                autofocus: true,
                style: TextStyle(fontSize: 20,),
                keyboardType: TextInputType.phone,
                // maxLength: 10,
                cursorColor: Colors.black54,
                cursorHeight: 25,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              FlatButton(
                height: 50,
                minWidth: 200,
                color: Colors.black54,
                onPressed: (){
                  loginUser(phoneEditingController.text, context);
                  // loginOtp(_phone);
                },
                child: Text(
                  'Send Otp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                onChanged: (String text)=> _otp=text,
                autofocus: true,
                style: TextStyle(fontSize: 20,),
                keyboardType: TextInputType.phone,
                // maxLength: 10,
                cursorColor: Colors.black54,
                cursorHeight: 25,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              FlatButton(
                height: 50,
                minWidth: 200,
                color: Colors.black54,
                onPressed: (){
                  // loginUser(_phone, context);
                  // loginOtp(_phone);
                  verifyOTP(_otp);
                },
                child: Text(
                  'Verify Otp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              FlatButton.icon(
                height: 50,
                minWidth: 200,
                color: Colors.white60,
                onPressed: ()=> _signIn().then((user) {
                  print('User Details');
                  print(user.user.displayName);
                  print(user.user.email);
                  print(user.user.uid);
                  print(user.user.photoURL);

                  // Navigator.pushNamed(context, '/dashboard');
                  // Navigator.push(context, MaterialPageRoute(
                  //     // builder: (context) => Dashboard(user.user)
                  // ));
                }).catchError((e)=> print(e)),
                icon: Icon(Icons.login),
                label: Text(
                  'G-Login',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
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
