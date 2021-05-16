import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudnotes/addnote.dart';
import 'package:cloudnotes/editdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/sighin.dart';

class TestScreen extends StatefulWidget {
  
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {





  final FirebaseAuth _auth = FirebaseAuth.instance;


  


  @override
  Widget build(BuildContext context) {
      CollectionReference ref = FirebaseFirestore.instance.collection(_auth.currentUser.uid);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => SignIn()));
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => Addnote()));
      },),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
          itemCount: snapshot.hasData?snapshot.data.docs.length:0,
          itemBuilder: (_, index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => EditNote(docToEdit: snapshot.data.docs[index],)));
              },
                          child: Container(
                margin: EdgeInsets.all(10),
                height: 150,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Text(snapshot.data.docs[index].data().values.elementAt(1)),
                    Text(snapshot.data.docs[index].data().values.elementAt(0)),

                  ],
                ),
              ),
            );
          }
          );
        }
      )
    );
  }


  // readData(){
  //   ref.
  // }
}

