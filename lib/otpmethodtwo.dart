// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class PhoneAuth extends StatefulWidget {
//   @override
//   _PhoneAuthState createState() => _PhoneAuthState();
// }
//
// class _PhoneAuthState extends State<PhoneAuth> {
//   String phoneNumber;
//   String verificationCode;
//
//   TextEditingController otpController;
//   TextEditingController phoneController;
//
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   String verificationId;
//
//   @override
//   void initState() {
//     otpController = TextEditingController();
//     phoneController = TextEditingController();
//     super.initState();
//   }
//
//   Future<void> verifyPhone(phoneNo) async {
//     final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
//       verificationId = verId;
//     };
//
//     final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
//       verificationId = verId;
//     };
//
//     final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
//       firebaseAuth.signInWithCredential(auth).then((UserCredential value) {
//         if (value.user != null) {
//           User user = value.user;
//           userAuthorized();
//         } else {
//           debugPrint('user not authorized');
//         }
//       }).catchError((error) {
//         debugPrint('error : $error');
//       });
//     };
//
//     final PhoneVerificationFailed veriFailed = (FirebaseAuthException exception) {
//       print('${exception.message}');
//     };
//
//     await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNo,
//         codeAutoRetrievalTimeout: autoRetrieve,
//         codeSent: smsCodeSent,
//         timeout: const Duration(seconds: 5),
//         verificationCompleted: verifiedSuccess,
//         verificationFailed: veriFailed);
//   }
//
//   void verifyOTP(String smsCode) async {
//     var _authCredential = PhoneAuthProvider.credential(
//         verificationId: verificationId, smsCode: smsCode);
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return Container(
//             color: Colors.white,
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         });
//     firebaseAuth
//         .signInWithCredential(_authCredential)
//         .then((UserCredential result) {
//       User user = result.user;
//
//       if (user != null) {
//         _showSnackBar();
//         userAuthorized();
//       }
//
//       ///go To Next Page
//     }).catchError((error) {
//       Navigator.pop(context);
//     });
//   }
//
//   userAuthorized() {
//     print('can go to next page');
//   }
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   _showSnackBar() {
//     final snackBar = new SnackBar(
//       content: Text("User LogedIn"),
//       duration: Duration(
//         seconds: 5,
//       ),
//     );
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               cursorColor: Colors.amber,
//               keyboardType: TextInputType.phone,
//               controller: phoneController,
//               decoration: InputDecoration(
//                 filled: true,
//                 // enabled: true,
//                 labelText: 'Enter phone Number',
//                 labelStyle: TextStyle(
//                   backgroundColor: Colors.transparent,
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.amber,
//                   ),
//                 ),
//                 fillColor: Colors.amber.withOpacity(0.1),
//                 focusColor: Colors.amber,
//                 hoverColor: Colors.amber,
//               ),
//               style: TextStyle(
//                 color: Colors.amber,
//                 backgroundColor: Colors.black54,
//                 decorationColor: Colors.black54,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 style: TextStyle(
//                   color: Colors.amber,
//                   backgroundColor: Colors.black54,
//                   decorationColor: Colors.black54,
//                 ),
//                 decoration: InputDecoration(
//                   filled: true,
//                   // enabled: true,
//                   labelText: 'Enter OTP',
//                   labelStyle: TextStyle(
//                     backgroundColor: Colors.transparent,
//                   ),
//                   disabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.amber,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.amber,
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.amber,
//                     ),
//                   ),
//                   fillColor: Colors.amber.withOpacity(0.1),
//                   focusColor: Colors.amber,
//                   hoverColor: Colors.amber,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   MaterialButton(
//                     color: Colors.amber,
//                     onPressed: () {
//                       verifyPhone('+91${phoneController.text.trim()}');
//                     },
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('Send OTP'),
//                       ),
//                     ),
//                   ),
//                   MaterialButton(
//                     color: Colors.amber,
//                     onPressed: () {
//                       verifyOTP(otpController.text.trim());
//                     },
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('Verify OTP'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
