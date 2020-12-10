import 'package:firebase_chat/services/auth.dart';
import 'package:firebase_chat/services/database.dart';
import 'package:firebase_chat/shared/loading.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email =" ";
  String _password;
  String _number;
  String error;
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading= false;


  @override
  Widget build(BuildContext context) {
    return loading? Loading() :Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.amber,
        elevation: 0,
        actions: [
          FlatButton.icon(
            onPressed: () async{
            widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('SignIn'),
          )
        ],
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              TextFormField(
                // controller: phoneEditingController,
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
              SizedBox(height: 20,),
              TextFormField(
                // controller: phoneEditingController,
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
              SizedBox(height: 20,),
              TextFormField(
                // controller: phoneEditingController,
                validator: (val)=> val.length!=10 ?'Enter a valid Number' :null,
                onChanged: (val){
                  _number='+91$val';
                },
                autofocus: true,
                style: TextStyle(fontSize: 20,),
                // maxLength: 10,
                cursorColor: Colors.black54,
                cursorHeight: 25,
                decoration: InputDecoration(
                  hintText: 'Phone',
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
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(_email, _password,_number).then((result) async{
                      if(result!=null){
                        Map<String,String> userDataMap = {
                          "phoneNumber" : _number,
                          "userEmail" : _email
                        };
                        await DatabaseMethods(uid: result.uid).addUserInfo(userDataMap);

                      }
                    });
                    if(result==null){
                      setState(() {
                        error= 'Please provide valid email';
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
            ],
          ),
        ),
      ),

    );
  }
}
