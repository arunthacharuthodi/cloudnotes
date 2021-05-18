import 'package:cloudnotes/screens/forgotpassword.dart';
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
  String _errorLogin;
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
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          alertBox2(),
          SizedBox(
            height: 40,
          ),
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
        GestureDetector(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (_)=> ForgotPassword()));
          },
                  child: Container(
            alignment: Alignment.centerRight,
            child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
          child: Text("forgot your password?"),
      ),
            ),
          ),
        ),
        SizedBox(height: 40,),
        GestureDetector(
          onTap: () async {
            try{
              
               UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: signinemailController.text, password: signinpasswordController.text);
               
               final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
               sharedPreferences.setString('email', signinemailController.text);

            }on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found' && signinemailController.text.isEmpty == false && signinpasswordController.text.isEmpty == false) {
                
                  setState(() {
                    _errorLogin = "user not found, if new please signup";
                  });
            
                
                } else if (e.code == 'wrong-password' && signinemailController.text.isEmpty == false && signinpasswordController.text.isEmpty == false) {
                  setState(() {
                    _errorLogin = "password is incorrect ";
                  });
                  // print('Wrong password provided for that user.');
                } else if (e.code == 'invalid-email' && signinemailController.text.isEmpty == false && signinpasswordController.text.isEmpty == false) {
                  setState(() {
                    _errorLogin = e.message;
                  });
                  // print('Wrong password provided for that user.');
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
            child: Text("SignIn",style: TextStyle(fontSize: 18, color: Colors.white, ),textAlign: TextAlign.center),
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
  Widget alertBox2(){
  if(_errorLogin != null){
    return Row(
      
      children: [
        Expanded(
          
              child: Center(
                child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10)
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.warning_rounded, color: Colors.red,),
                 Text("$_errorLogin",textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),)
              ],
            )
          ),
              ),
        ),
      ],
    );
  }else{
    return SizedBox(
      height: 20,
    );
  }

}
}