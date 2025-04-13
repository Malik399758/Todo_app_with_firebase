import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_firebase/controller/firebase_services/firebase_service.dart';
import 'package:todo_app_firebase/views/auth_module/signup_signin_screen.dart';
import 'package:todo_app_firebase/views/main_home_screen/home_screen1.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false;
  final firebaseFireStore =  FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final Timestamp? timestamp = Timestamp.now();

  bool isActive = false;

  void checkTask(){
    setState(() {
      isActive = !isActive;
    });
  }
  // sign out

  // Add Data
  Future<void> addData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await firebaseFireStore.collection('todo_app_details').add({
        'title' : titleController.text,
        'description' : descriptionController.text,
        'timestamp' : timestamp ?? Timestamp.now(),
        'isCompleted': false, // ✅ Add this line
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Data added successfully!!',style: GoogleFonts.poppins(
              color: Colors.white
          ),)));
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print('Data added error ----------->$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Data added issue try again',style: GoogleFonts.poppins(
              color: Colors.white
          ),)));
      setState(() {
        isLoading = false;
      });
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

/*  // get Data
  Stream<QuerySnapshot> getData(){
    return FirebaseFirestore.instance.collection('todo_app_details').snapshots();
  }
  
  // delete Data
  Future<void> deleteData(String id)async{
    await FirebaseFirestore.instance.collection('todo_app_details').doc(id).delete();
  }*/

  Future<void> accountSignOut()async{
    await FirebaseAuth.instance.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              color: Colors.white,
              icon: Icon(Icons.more_vert, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (value) {
                if (value == 'signout') {
                  try {
                    accountSignOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Account sign out successfully!!',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupSigninScreen()),
                    );
                  } catch (e) {
                    print('Error ------->$e');
                  }
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'signout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Sign Out', style: GoogleFonts.poppins()),
                    ],
                  ),
                ),
                // Add more menu items here if needed
              ],
            ),
          )

        ],
        title: Text('Add task',style: GoogleFonts.poppins(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title'
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: 'Description'
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: ()async{
                await addData();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen1()));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isLoading? Center(child: SpinKitRotatingCircle(color: Colors.white,size: 20,))
                    :Center(child: Text('ADD',style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),)),
              ),
            ),
            SizedBox(height: 15,),
            Divider(),
          ],
        ),
      ),
    );
  }
}
