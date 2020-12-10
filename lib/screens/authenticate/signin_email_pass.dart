import 'package:firebase_chat/services/auth.dart';
import 'package:firebase_chat/services/database.dart';
import 'package:firebase_chat/shared/loading.dart';
import 'package:flutter/material.dart';

class SignInWithEmailPassword extends StatefulWidget {

  final Function toggleView;
  SignInWithEmailPassword({this.toggleView});


  @override
  _SignInWithEmailPasswordState createState() => _SignInWithEmailPasswordState();
}

class _SignInWithEmailPasswordState extends State<SignInWithEmailPassword> {

  String error = ' ';
  String _email;
  String _password;
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading= false;

  @override
  Widget build(BuildContext context) {

    return loading? Loading() :Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.amber,
        elevation: 0,
        actions: [
          FlatButton.icon(
            onPressed: () async{
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (val){
                        _email=val;
                      },
                      validator: (val)=> val.isEmpty?'Enter an email' :null,
                      autofocus: true,
                      style: TextStyle(fontSize: 20,),
                      // maxLength: 10,
                      cursorColor: Colors.black54,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        hintText: 'Email Id',
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
                    SizedBox(height: 40,),
                    TextFormField(
                      obscureText: true,
                      validator: (val)=> val.length<6 ?'Enter a password 6< chars' :null,
                      onChanged: (val){
                        _password=val;
                      },
                      autofocus: true,
                      style: TextStyle(fontSize: 20,),
                      // maxLength: 10,
                      cursorColor: Colors.black54,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(_email, _password).then((result) {
                      if(result!=null){
                        DatabaseMethods().getUserInfo(_email);
                      }
                    });
                    if(result==null){
                      setState(() {
                        error= 'Could not sign in with credential';
                        loading = false;
                      });
                    }
                  }
                },
                color: Colors.amber,
                child: Text('Sign In'),
              ),
              SizedBox(height: 20,),
              Text(
                error.toString(),
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20,),

              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
