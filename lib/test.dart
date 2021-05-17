import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudnotes/addnote.dart';
import 'package:cloudnotes/editdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
        title: Text("Cloud Notes"),
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






      body: Stack(
               children:[
                  Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                    HexColor("EFEFEF"), HexColor("ffffff")
                  ])
                ),
              ),
              // ClipPath(
              //   clipper: bottomcontainerclip(),
              //   child: Container(
              //     color: Colors.deepOrange,
                  
              //   ),
              // ),
                
                
                
                
                
                
                
                
                
                Container(
          child: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .8, 
              ), 
              itemCount: snapshot.hasData?snapshot.data.docs.length:0,
              itemBuilder: (_, index){


                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => EditNote(docToEdit: snapshot.data.docs[index],)));
                  },
                  child: Card(
                    
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(30),
                        // color: Colors.grey[200],
                      ),
                      margin: EdgeInsets.all(1),
                      // height: 200,
                      
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                                            child: Column(
                                              
                            
                            children: [
                              Text(snapshot.data.docs[index].data().values.elementAt(1), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, 
                              color: Colors.black
                              
                              ),),
                              SizedBox(height: 10,),
                              Text(snapshot.data.docs[index].data().values.elementAt(0), style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, 
                              color: Colors.black87
                              
                              ),),

                            ],
                          ),
                        ),
                      ),
                    ),
                              ),
                );
              }
              );
            }
          ),
        )],
      )
    );
  }



  


  // readData(){
  //   ref.
  // }
}
// class bottomcontainerclip extends CustomClipper<Path> {
//  @override
//   Path getClip(Size size) {
//     Path path = Path();
//     final double _xScaling = size.width / 414;
//     final double _yScaling = size.height / 896;
//     path.lineTo(6.26105 * _xScaling,506.881 * _yScaling);
//     path.cubicTo(2.19483 * _xScaling,510.066 * _yScaling,-3.88392 * _xScaling,517.837 * _yScaling,-7.82447 * _xScaling,522.867 * _yScaling,);
//     path.cubicTo(-8.72284 * _xScaling,527.729 * _yScaling,-10.9059 * _xScaling,531.103 * _yScaling,-11.9246 * _xScaling,536.536 * _yScaling,);
//     path.cubicTo(-16.2374 * _xScaling,559.538 * _yScaling,-17.2133 * _xScaling,583.728 * _yScaling,-18.0709 * _xScaling,607.124 * _yScaling,);
//     path.cubicTo(-18.6845 * _xScaling,623.861 * _yScaling,-16.5944 * _xScaling,640 * _yScaling,-14.776 * _xScaling,656.612 * _yScaling,);
//     path.cubicTo(-12.6868 * _xScaling,675.697 * _yScaling,-11.8391 * _xScaling,695.227 * _yScaling,-8.94645 * _xScaling,714.21 * _yScaling,);
//     path.cubicTo(-7.17485 * _xScaling,725.836 * _yScaling,-4.02441 * _xScaling,736.653 * _yScaling,6.64124 * _xScaling,743.168 * _yScaling,);
//     path.cubicTo(15.3987 * _xScaling,748.517 * _yScaling,24.3718 * _xScaling,749.936 * _yScaling,34.3316 * _xScaling,751.469 * _yScaling,);
//     path.cubicTo(50.5511 * _xScaling,753.964 * _yScaling,67.3698 * _xScaling,753.369 * _yScaling,83.6926 * _xScaling,753.369 * _yScaling,);
//     path.cubicTo(104.071 * _xScaling,753.369 * _yScaling,130.769 * _xScaling,753.195 * _yScaling,151.112 * _xScaling,752.863 * _yScaling,);
//     path.cubicTo(203.002 * _xScaling,752.014 * _yScaling,255.199 * _xScaling,752.067 * _yScaling,306.989 * _xScaling,748.681 * _yScaling,);
//     path.cubicTo(335.699 * _xScaling,746.803 * _yScaling,364.398 * _xScaling,743.405 * _yScaling,393.038 * _xScaling,740.633 * _yScaling,);
//     path.cubicTo(410.863 * _xScaling,738.908 * _yScaling,426.903 * _xScaling,734.516 * _yScaling,436.126 * _xScaling,716.745 * _yScaling,);
//     path.cubicTo(446.626 * _xScaling,696.514 * _yScaling,448.995 * _xScaling,665.248 * _yScaling,450.447 * _xScaling,644.002 * _yScaling,);
//     path.cubicTo(452.815 * _xScaling,609.332 * _yScaling,454.401 * _xScaling,571.656 * _yScaling,450.573 * _xScaling,536.916 * _yScaling,);
//     path.cubicTo(448.141 * _xScaling,514.841 * _yScaling,440.091 * _xScaling,493.425 * _yScaling,421.299 * _xScaling,479.761 * _yScaling,);
//     path.cubicTo(403.526 * _xScaling,466.838 * _yScaling,385.695 * _xScaling,470.056 * _yScaling,366.172 * _xScaling,464.807 * _yScaling,);
//     path.cubicTo(346.538 * _xScaling,459.528 * _yScaling,359.038 * _xScaling,457.423 * _yScaling,335.06 * _xScaling,453.592 * _yScaling,);
//     path.cubicTo(306.86 * _xScaling,449.086 * _yScaling,287.713 * _xScaling,459.769 * _yScaling,262.761 * _xScaling,470.13 * _yScaling,);
//     path.cubicTo(240.347 * _xScaling,479.437 * _yScaling,228.569 * _xScaling,475.403 * _yScaling,206.683 * _xScaling,466.518 * _yScaling,);
//     path.cubicTo(190.158 * _xScaling,459.809 * _yScaling,169.211 * _xScaling,447.811 * _yScaling,150.606 * _xScaling,447.952 * _yScaling,);
//     path.cubicTo(140.889 * _xScaling,448.026 * _yScaling,135.477 * _xScaling,454.145 * _yScaling,128.935 * _xScaling,460.372 * _yScaling,);
//     path.cubicTo(111.719 * _xScaling,476.758 * _yScaling,97.0954 * _xScaling,494.712 * _yScaling,73.681 * _xScaling,502.763 * _yScaling,);
//     path.cubicTo(59.2367 * _xScaling,507.729 * _yScaling,52.2103 * _xScaling,506.109 * _yScaling,38.0701 * _xScaling,503.967 * _yScaling,);
//     path.cubicTo(26.2242 * _xScaling,502.172 * _yScaling,16.6586 * _xScaling,498.737 * _yScaling,6.26105 * _xScaling,506.881 * _yScaling,);
//     path.cubicTo(6.26105 * _xScaling,506.881 * _yScaling,6.26105 * _xScaling,506.881 * _yScaling,6.26105 * _xScaling,506.881 * _yScaling,);
//     return path;
//   }
  
//     @override
//     bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     // TODO: implement shouldReclip
//     return false;
//   }

// }

