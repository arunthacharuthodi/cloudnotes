import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addnote extends StatelessWidget {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  // CollectionReference ref = FirebaseFirestore.instance.collection("notes");   
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection(_auth.currentUser.uid);
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(onPressed: (){
            ref.add({
              'title': title.text,
              'content':content.text
            }).whenComplete(() => Navigator.pop(context));
          }, 
          child: Text("save"))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          
          children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: "title", 

              ),
            )
          ),
          SizedBox(height: 20,),
           Expanded(
                      child: Container(
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: TextField(
                controller: content,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "content", 
                  
                  
                ),
              )
          ),
           )
        ],),
      ),
    );
  }
}