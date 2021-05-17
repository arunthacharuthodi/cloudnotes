import 'package:cloudnotes/screens/sighin.dart';
import 'package:cloudnotes/test.dart';
import 'package:cloudnotes/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  bool tikstate = false;
  bool outsideornot = false;
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  void OutSider(){

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(context),
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
                  
                  decoration: InputDecoration(
                    hintText: "First Name"
                    
                  ),
                ),
                SizedBox(height:20 ,),
                TextFormField(
                  
                  decoration: InputDecoration(
                    hintText: "Last Name"
                    
                  ),
                ),
                SizedBox(height:20 ,),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email address"
                    
                  ),
                ),
                SizedBox(height:20 ,),
                TextFormField(
                  controller: passwordController,
                  
                  decoration: InputDecoration(
                    hintText: "password"
                    
                  ),
                ),
                SizedBox(height:20 ,),
                TextFormField(
                  
                  decoration: InputDecoration(
                    hintText: "Re enter password"
                    
                  ),
                ),
                SizedBox(height:50 ,),
                GestureDetector(
                onTap: (){
                  _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                  FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User user) {
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> TestScreen()));
                    }
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
                SizedBox(height:20 ,),
                Text("OR"),
                SizedBox(height:20 ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("do you already have a account?"),
                    GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> SignIn()));
                    },
                      child: Text("Sign in here",style: TextStyle(decoration:TextDecoration.underline,))),
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