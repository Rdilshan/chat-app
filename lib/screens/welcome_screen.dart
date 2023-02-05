import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();
    controller.addListener(() {
      setState(() {
        //print(controller.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30.0,
                ),
                Hero(
                  tag: 'log',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value * 60,
                  ),
                ),
                // Text(
                //   'Flash Chat',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Flash Chat'),
                      TyperAnimatedText('Flash Chat'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            button(Colors.lightBlueAccent, () {
              going_rout(context, "login_screen");
            }, Text("Log In")),
            button(Colors.blueAccent, () {
              going_rout(context, 'registration_screen');
            }, Text("Register")),
          ],
        ),
      ),
    );
  }
}
