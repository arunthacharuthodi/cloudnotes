import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget MainAppBar(BuildContext context){
  return AppBar(
    title: Text("GecwPay"),
  );
}

Widget TextFieldCustom(hinttext){
  return TextField(
              decoration: InputDecoration(
                hintText: hinttext,
              ));
}

Widget NextButton(BuildContext context, String textcustom){
  return GestureDetector(
    onTap: (){
      

    },
      child: Container(
                
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15,),
                child: Text(textcustom,style: TextStyle(fontSize: 18, color: Colors.white, ),textAlign: TextAlign.center),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xff007EF4),
                    const Color(0xff2A75BC)
                  ]),
                  borderRadius: BorderRadius.circular(10) ),
                
              ),
  );
}
Widget OutSiderSignUP(){
  Container(
    child: Column(children: [
      TextFieldCustom("first name"),
      TextFieldCustom("Last name"),
      
    ],),
  );
}