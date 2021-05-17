import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addnote extends StatefulWidget {

  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

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
          child: Text("save", style: TextStyle(color: Colors.white,),))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          
          children: [
          TextFormField(
            controller: title,
                  decoration: InputDecoration(hintText: "title",
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black12, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black12, width: 2),
                  ),
                  ),),
          SizedBox(height: 20,),
           Expanded(
                      child:TextFormField(
                        maxLines: 20,
                        controller: content,
                  decoration: InputDecoration(hintText: "write here!!",
                  contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black12, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black12, width: 2),
                  ),
                  ),),
          ),
           
        ],),
      ),
    );
  }
}