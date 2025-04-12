import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{

  // get Data
  Stream<QuerySnapshot> getData(){
    return FirebaseFirestore.instance.collection('todo_app_details').snapshots();
  }

  // delete Data
  Future<void> deleteData(String id)async{
    await FirebaseFirestore.instance.collection('todo_app_details').doc(id).delete();
  }

  // update Data

 Future<void> updateData(String title,String description,String id)async{
    return FirebaseFirestore.instance.collection('todo_app_details').doc(id).update({
      'title' : title,
      'description' : description
    });
 }




}