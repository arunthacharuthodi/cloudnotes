import 'package:cloudnotes/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  bool _emailsent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: 30,),
            _sendEmail(),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Text("sent verification"),
                  onPressed: ()async{
                   User user = FirebaseAuth.instance.currentUser;

                  if (!user.emailVerified) {
                    try {
                      await user.sendEmailVerification().whenComplete(() {
                        setState(() {
                          _emailsent = true;
                        });
                      });
                    } catch (e) {
                      print(e);
                    }
                  }else{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => TestScreen()));
                  }
                }),
                RaisedButton(
                  child: Text("already verified"),
                  onPressed: (){
                  User user = FirebaseAuth.instance.currentUser;
                   if (!user.emailVerified){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => TestScreen()));

                   }
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _sendEmail(){
    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified){
      return Container(
        height: 40,
        child: Text("please verify your  email"),
      );

    }else if(_emailsent == true){
      return Container(
        height: 40,
        child: Text("verification email is sent to your email box"),
      );
    }
    
    else{
      return SizedBox(
        height: 40,

      );
    }
  }
}