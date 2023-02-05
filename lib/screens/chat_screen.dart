import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

final Textcontroll = TextEditingController();
FirebaseFirestore firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
late var Login_email;
var msg;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Text> messageWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentUser();
    massagestream();
  }

  //get couurent user
  void getcurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        Login_email = user.email;
        print(user.email);
        print("User name");
      }
    } catch (e) {
      print(e);
    }
  }

  void massagestream() async {
    await for (var varshot in firestore
        .collection('massage')
        .orderBy('timestamp', descending: true)
        .snapshots()) {
      //Map<String, dynamic> data = varshot.docs! as Map<String, dynamic>;
      for (var massagess in varshot.docs) {
        print(massagess.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                try {
                  _auth.signOut();
                  going_rout(context, 'welcome_screen');
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            stream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: Textcontroll,
                      onChanged: (value) {
                        msg = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Textcontroll.clear();
                      //Implement send functionality.
                      firestore
                          .collection('massage')
                          .add({'text': msg, 'user': Login_email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class stream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('massage').snapshots(),
      builder: (context, snapshot) {
        bool isme;
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          );
        }
        final msg = snapshot.data!.docs;
        List<Masgbox> msgList = [];
        for (var x in msg) {
          final msgText = x['text'];
          final msgsender = x['user'];
          isme = (msgsender == Login_email);
          final textwidet = Masgbox(msgText, msgsender, isme);

          msgList.add(textwidet);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: msgList,
          ),
        );
      },
    );
  }
}

//msg box
class Masgbox extends StatelessWidget {
  String msgText;
  String msgsender;
  bool Isme;
  Masgbox(this.msgText, this.msgsender, this.Isme);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            Isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            msgsender,
            style: TextStyle(fontSize: 12),
          ),
          Material(
            borderRadius: BorderRadius.circular(3.0),
            elevation: 15.0,
            color: Isme ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                '$msgText',
                style: TextStyle(
                    fontSize: 15.0, color: Isme ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
