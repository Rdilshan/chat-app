import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

//button Login/Registration
class button extends StatelessWidget {
  Color col;
  final Function()? onTap;

  Text titil;
  // ignore: use_key_in_widget_constructors
  button(this.col, this.onTap, this.titil);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          color: col,
          borderRadius: BorderRadius.circular(30.0),
          elevation: 5.0,
          child: MaterialButton(
              onPressed: onTap,

              //Navigator.pushNamed(context, 'registration_screen');

              minWidth: 200.0,
              height: 42.0,
              child: titil),
        ),
      ),
    );
  }
}

void going_rout(BuildContext context, String rout) {
  Navigator.pushNamed(context, '$rout');
}

//reg auth save

// void ReigterUser(
//     String passward, String email, BuildContext context, String rout) {
//   _auth.createUserWithEmailAndPassword(email: email, password: passward);
//   going_rout(context, rout);
// }

//enter text feild

const enterText = InputDecoration(
  hintText: 'Enter your password',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
