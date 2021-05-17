import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditNote({this.docToEdit});
  
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.data().values.elementAt(1));
    content = TextEditingController(text: widget.docToEdit.data().values.elementAt(0));
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(onPressed: (){
            widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
            // ref.add({
            //   'title': title.text,
            //   'content':content.text
            // }).whenComplete(() => Navigator.pop(context));
          }, 
          child: Text("delete", style: TextStyle(color: Colors.white,))),

          FlatButton(onPressed: (){
            widget.docToEdit.reference.update({
              'title': title.text,
              'content':content.text
            }).whenComplete(() => Navigator.pop(context));
            // ref.add({
            //   'title': title.text,
            //   'content':content.text
            // }).whenComplete(() => Navigator.pop(context));
          }, 
          child: Text("save", style: TextStyle(color: Colors.white,)))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          
          children: [TextFormField(
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