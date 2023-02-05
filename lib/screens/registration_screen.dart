import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:delayed_consumer_hud/delayed_consumer_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String passward;
  late String email;
  var isBusy = false;

  @override
  Widget build(BuildContext context) {
    return DelayedHud(
        hud: CircularProgressIndicator(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Hero(
                    tag: 'log',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration:
                          enterText.copyWith(hintText: 'Enter your email')),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      onChanged: (value) {
                        passward = value;
                      },
                      decoration:
                          enterText.copyWith(hintText: 'Enter your password')),
                  SizedBox(
                    height: 24.0,
                  ),
                  button(Colors.blueAccent, () async {
                    //going_rout(context, 'login_screen');
                    setState(() {
                      isBusy = true;
                    });
                    print("run fun");

                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: passward);
                      print('okya');
                      if (user != null) {
                        going_rout(context, 'chat_screen');
                      }
                      setState(() {
                        isBusy = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }, Text("Register")),
                ],
              ),
            ),
          ),
        ),
        showHud: () => isBusy);
  }
}
