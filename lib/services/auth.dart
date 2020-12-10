import 'package:firebase_chat/models/user.dart';
import 'package:firebase_chat/screens/authenticate/basesignin.dart';
import 'package:firebase_chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;
  @observable
  User firebaseUser;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();

  UserModel _userFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid) : null;
  }
  //  Auth change User Steram
  Stream<UserModel> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //signIn Anon
  Future signInAnon()async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

//  SignOut
//   Future signOut() async {
//     try{
//       return await _auth.signOut();
//     }catch(e){
//       print(e.toString());
//       return null;
//     }
//   }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SignIn()),
            (Route<dynamic> route) => false);
    firebaseUser = null;
  }


//  Sign In Using GoogleSignIn
  Future<UserCredential> signInWithGoogle() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }


//  Sign In Using Email And passWord
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Register Using Email And passWord
  Future registerWithEmailAndPassword(String email, String password, String number) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

//  otp
//   Future<bool> loginUser(String phone, BuildContext context) async{
//
//     final PhoneCodeSent smsCodeSent = (String verId, [int forceResendingToken]){
//       verificationId = verId;
//     };
//     _auth.verifyPhoneNumber(
//       phoneNumber: phone,
//       timeout: Duration(seconds: 60),
//       verificationCompleted: (AuthCredential credential) async{
//         Navigator.of(context).pop();
//
//         await _auth.signInWithCredential(credential).then((result) async {
//           User user = result.user;
//           // if(user != null){
//           //   _showSnackBar();
//           //   Navigator.push(context, MaterialPageRoute(
//           //       builder: (context) => Dashboard(user)
//           //   ));
//           // }else{
//           //   print("Error");
//           // }
//           if (user != null)  {
//
//           }
//
//         });
//
//
//       },
//       verificationFailed: (FirebaseAuthException exception){
//         print(exception);
//       },
//       codeSent: smsCodeSent,
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-resolution timed out...
//       },
//     );
//     return false;
//   }
//   var verificationId;
//
//   void verifyOTP(String smsCode) async{
//     var _authCredential = PhoneAuthProvider.credential(
//         verificationId: verificationId, smsCode: smsCode);
//     // showDialog(
//     //     // context: context,
//     //     barrierDismissible: false,
//     //     builder: (context) {
//     //       return Container(
//     //         color: Colors.white,
//     //         child: Center(
//     //           child: CircularProgressIndicator(),
//     //         ),
//     //       );
//     //     });
//     _auth
//         .signInWithCredential(_authCredential)
//         .then((UserCredential result) {
//       User user = result.user;
//
//       if (user != null) {
//
//         userAuthorized();
//       }
//       // Navigator.push(context, MaterialPageRoute(
//       //     // builder: (context) => Dashboard(user)
//       // ));
//       ///go To Next Page
//     }).catchError((error) {
//       print(error.toString());
//       // Navigator.pop(context);
//     });
//   }
//   userAuthorized() {
//     print('can go to next page');
//   }

  // @action
  // Future<bool> isAlreadyAuthenticated() async {
  //   firebaseUser = await _auth.currentUser;
  //   if (firebaseUser != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // @action
  // Future<void> getCodeWithPhoneNumber(
  //     BuildContext context, String phoneNumber) async {
  //   isLoginLoading = true;
  //
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted: (AuthCredential auth) async {
  //         await _auth.signInWithCredential(auth).then((AuthResult value) {
  //           if (value != null && value.user != null) {
  //             print('Authentication successful');
  //             onAuthenticationSuccessful(context, value);
  //           } else {
  //             loginScaffoldKey.currentState.showSnackBar(SnackBar(
  //               behavior: SnackBarBehavior.floating,
  //               backgroundColor: Colors.red,
  //               content: const Text(
  //                 'Invalid code/invalid authentication',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ));
  //           }
  //         }).catchError((error) {
  //           loginScaffoldKey.currentState.showSnackBar(SnackBar(
  //             behavior: SnackBarBehavior.floating,
  //             backgroundColor: Colors.red,
  //             content: const Text(
  //               'Something has gone wrong, please try later',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ));
  //         });
  //       },
  //       verificationFailed: (AuthException authException) {
  //         print('Error message: ' + authException.message);
  //         loginScaffoldKey.currentState.showSnackBar(SnackBar(
  //           behavior: SnackBarBehavior.floating,
  //           backgroundColor: Colors.red,
  //           content: Text(
  //             'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ));
  //         isLoginLoading = false;
  //       },
  //       codeSent: (String verificationId, [int forceResendingToken]) async {
  //         actualCode = verificationId;
  //         isLoginLoading = false;
  //         await Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (_) => const OtpPage()));
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         actualCode = verificationId;
  //       });
  // }
  //
  // @action
  // Future<void> validateOtpAndLogin(BuildContext context, String smsCode) async {
  //   isOtpLoading = true;
  //   final AuthCredential _authCredential = PhoneAuthProvider.getCredential(
  //       verificationId: actualCode, smsCode: smsCode);
  //
  //   await _auth.signInWithCredential(_authCredential).catchError((error) {
  //     isOtpLoading = false;
  //     otpScaffoldKey.currentState.showSnackBar(SnackBar(
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.red,
  //       content: Text(
  //         'Wrong code ! Please enter the last code received.',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ));
  //   }).then((AuthResult authResult) {
  //     if (authResult != null && authResult.user != null) {
  //       print('Authentication successful');
  //       onAuthenticationSuccessful(context, authResult);
  //     }
  //   });
  // }
  //
  // Future<void> onAuthenticationSuccessful(
  //     BuildContext context, AuthResult result) async {
  //   isLoginLoading = true;
  //   isOtpLoading = true;
  //
  //   firebaseUser = result.user;
  //
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (_) => const HomePage()),
  //           (Route<dynamic> route) => false);
  //
  //   isLoginLoading = false;
  //   isOtpLoading = false;
  // }


}