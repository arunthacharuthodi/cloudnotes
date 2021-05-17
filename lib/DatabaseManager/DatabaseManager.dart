import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{

CollectionReference firestoreInstance = FirebaseFirestore.instance.collection('users');

Future receiveData() async {
   try {
  firestoreInstance.get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
    });
  });
   } catch (e) {
     print(e);
   }
}
  
}
