import 'package:chatting_app/screens/chat_screen.dart';
import 'package:chatting_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/components/rounded_button.dart';
import 'package:chatting_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class RegistrationScreen extends StatefulWidget {
  static const String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner=false;
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Email Id'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              rounded_button(title: 'Register', colour: Colors.blueAccent, onPressed: () async{
                setState((){
                  showSpinner=true;
                });
                try{
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(newUser!=null){
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  }
                  setState((){
                    showSpinner=false;
                  });
                }
                catch(e){
                  print(e);
                }
              },),
            ],
          ),
        ),
      ),
    );
  }
}