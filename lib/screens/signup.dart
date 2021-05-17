import 'package:cloudnotes/screens/emailVerification.dart';
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

  String _error;


  bool tikstate = false;
  bool outsideornot = false;
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController password2 = new TextEditingController();
  var formKey = GlobalKey<FormState>();




  checkall(){
    if(formKey.currentState.validate()){
      return true;
    }else{
      return false;
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
                  child: Container(
                    
                    height: MediaQuery.of(context).size.height -150 ,
            child: Form(
              key: formKey,
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  alertBox(),
                  SizedBox(height:30 ,),
                  TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "required";
                      }else{
                        return null;
                      }
                    },
                    controller: firstName,
                    decoration: InputDecoration(
                      hintText: "First Name"
                      
                    ),
                  ),
                  SizedBox(height:20 ,),
                  TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "required";
                      }else{
                        return null;
                      }
                    },
                    controller: lastName,
                    decoration: InputDecoration(
                      hintText: "Last Name"
                      
                    ),
                  ),
                  SizedBox(height:20 ,),
                  TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "required";
                      }
                      else{
                        return null;
                      }
                    },
                    // validator: validate,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email address"
                      
                    ),
                  ),
                  SizedBox(height:20 ,),
                  TextFormField(
                    obscureText: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "required";
                      }else{
                        return null;
                      }
                    },
                    controller: passwordController,
                    
                    decoration: InputDecoration(
                      hintText: "password"
                      
                    ),
                  ),
                  SizedBox(height:20 ,),
                  TextFormField(
                    obscureText: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "required";
                      }else if(passwordController.text != password2.text){
                        return "passwords dont match";
                      }else{
                        return null;
                      }
                    },
                    controller: password2,
                    decoration: InputDecoration(
                      hintText: "Re enter password"
                      
                    ),
                  ),
                  SizedBox(height:40 ,),
                  GestureDetector(
                  onTap: ()async{
                    final val = checkall();
                   if(val == true){
                      try {
                         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                         if(userCredential.additionalUserInfo.isNewUser){
                           Navigator.push(context, MaterialPageRoute(builder: (_)=> Email()));
                         }
                      }on FirebaseAuthException catch (e) {
                        print(e);
                        if(e.code ==  'email-already-in-use'){
                          setState(() {
                            _error = "email is already in use by someone";
                          });
                        
                        }else if(e.code == "invalid-email" ){
                          setState(() {
                            _error = e.message;
                          });
                        }else if(e.code == "weak-password"){
                          setState(() {
                            _error = e.message;
                          });

                        }
                        
                      }
                   }else{
                     return "valerror";
                   }

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
                  SizedBox(height:20 ,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("do you already have a account?"),
                      GestureDetector(onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => SignIn()));
                      },
                        child: Text("Sign in here",style: TextStyle(decoration:TextDecoration.underline,))),
                    ],
                  ),
                  
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  
Widget alertBox(){
  if(_error != null){
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
                 Text("$_error",textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),)
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