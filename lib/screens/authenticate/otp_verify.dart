import 'package:flutter/material.dart';
class VerifyOtp extends StatefulWidget {
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  String _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text('Verify OTP'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

                },
                child: Text(
                  'Verify Otp',
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
