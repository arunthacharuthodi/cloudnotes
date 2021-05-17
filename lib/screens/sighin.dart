import 'package:cloudnotes/screens/signup.dart';
import 'package:cloudnotes/test.dart';
import 'package:cloudnotes/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';





class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  bool _secure = true;
  TextEditingController signinemailController = TextEditingController();
  TextEditingController signinpasswordController = TextEditingController();
  bool signinvalidateemail = false;
  bool signinvalidatepassword = false;
  bool usrnotfound,passwordincorrect;
    final _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height -200 ,
                            child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
        TextFormField(
          controller: signinemailController,
           decoration: InputDecoration(
                hintText: "Email adress",
                errorText: signinvalidateemail ? 'Email Can\'t Be Empty' : null,
                
                
              )
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: signinpasswordController,
          obscureText: _secure,
          decoration: InputDecoration(
            errorText: signinvalidatepassword ? 'Password Can\'t Be Empty' : null,    
            hintText: "password",
            suffixIcon: IconButton(
            icon: Icon(
              _secure ? Icons.security : Icons.remove_red_eye
              ),
            onPressed: () { 
              setState(() {
                  _secure = ! _secure;
              });
            },

      )
          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        child: Text("forgot your password?"),
      ),
          ),
        ),
        SizedBox(height: 40,),
        GestureDetector(
          onTap: () async {
            try{
              
               _auth.signInWithEmailAndPassword(email: signinemailController.text, password: signinpasswordController.text);
               final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
               sharedPreferences.setString('email', signinemailController.text);

            }on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found' && signinemailController.text.isEmpty == false && signinpasswordController.text.isEmpty == false) {
                
                
            
                
                } else if (e.code == 'wrong-password' && signinemailController.text.isEmpty == false && signinpasswordController.text.isEmpty == false) {
                  setState(() {
                    passwordincorrect = true;
                  });
                  print('Wrong password provided for that user.');
                }
              }

              FirebaseAuth.instance
              .authStateChanges()
              .listen((User user) {
                if (user == null) {
                  print('User is currently signed out!');
                  
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => TestScreen()));
                }
              });
              setState(() {
                signinemailController.text.isEmpty ? signinvalidateemail = true : signinvalidateemail = false;
                signinpasswordController.text.isEmpty ? signinvalidatepassword = true : signinvalidatepassword = false;
              });
          },
                  child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 15,),
            child: Text("SignUp",style: TextStyle(fontSize: 18, color: Colors.white, ),textAlign: TextAlign.center),
            decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
          const Color(0xff007EF4),
          const Color(0xff2A75BC)
      ]),
      borderRadius: BorderRadius.circular(10) ),
      
            
          ),
        ),
        SizedBox(height: 50,),
         
        SizedBox(height: 20,),


        SizedBox(height: 20,),
       
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      Text("Dont have a account?"),
      GestureDetector(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => SignUp()));
        },
        child: Text("Register here",style: TextStyle(decoration:TextDecoration.underline,),))
          ],
        ),


        ],
      ),
                          ),
            ),
          ),
    );
  }
}