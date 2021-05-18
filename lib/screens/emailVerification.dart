import 'dart:async';

import 'package:cloudnotes/screens/sighin.dart';
import 'package:cloudnotes/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  





  bool _emailsent;

  @override
  void initState() {
    user =  auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
        checkEmailVerified();
     });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.email),
                Container(
                  
                  child: Text("an email has sent to \n ${user.email} please verify ", textAlign: TextAlign.center,)),
              ],
            )
          ),
        ),
      )
    );
  }

  Future<void> checkEmailVerified()async{
    user = auth.currentUser;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignIn()));
    }
  }
}