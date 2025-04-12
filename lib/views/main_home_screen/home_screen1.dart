import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_firebase/controller/firebase_services/firebase_service.dart';
import 'package:todo_app_firebase/views/auth_module/signup_signin_screen.dart';
import 'package:todo_app_firebase/views/main_home_screen/add_task_screen.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final updateTitleController = TextEditingController();
  final updateDescriptionController = TextEditingController();

  final firebaseService = FirebaseService();

  // sign out
  Future<void> accountSignOut()async{
    await FirebaseAuth.instance.signOut();
  }

  // update dialog here
  Future updateDialog(BuildContext context,String index)async{
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Update Data',style: GoogleFonts.poppins(),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: updateTitleController,
              decoration: InputDecoration(
                  hintText: 'Title'
              ),
            ),
            TextFormField(
              controller: updateDescriptionController,
              decoration: InputDecoration(
                  hintText: 'Description'
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: (){
            Navigator.pop(context);
          }, child: Text('No')),
          GestureDetector(
            onTap: (){
              firebaseService.updateData(updateTitleController.text, updateDescriptionController.text,index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Data updated successfully!!',style: GoogleFonts.poppins(
                      color: Colors.white
                  ),)));
            },
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue
              ),
              child: Center(child: Text('Update',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500),)),
            ),
          )
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  try{
                    accountSignOut();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                        content: Text('Account sign out successfully!!',style: GoogleFonts.poppins(
                          color: Colors.white
                        ),)));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupSigninScreen()));

                  }catch(e){
                    print('Error ------->$e');
                  }
                },
                  child: Icon(Icons.more_vert,color: Colors.white,)),
            )
          ],
          title: Text('Todo App',style: GoogleFonts.poppins(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: StreamBuilder(
              stream: firebaseService.getData(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(
                    color: Colors.green,
                  ));
                }else if(snapshot.hasError){
                  return Center(child: Text('Something went wrong'));
                }else if(!snapshot.hasData){
                  return Center(child: Text('Data not found'));
                }else{
                  var show = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          DateTime dateTime = (show[index]['timestamp'] as Timestamp).toDate();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  child: ListTile(
                                    title: Text(show[index]['title'],style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
                                    subtitle: Text(show[index]['description'],style: GoogleFonts.poppins(fontSize: 12),),
                                    trailing: Row(
                                      mainAxisSize : MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            updateTitleController.text = show[index]['title'];
                                            updateDescriptionController.text = show[index]['description'];
                                    updateDialog(context,show[index].id);
                                  },
                                            child: Icon(Icons.edit_outlined)),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                            onTap : (){
                                              firebaseService.deleteData(show[index].id);
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text('Data deleted successfully!!',style: GoogleFonts.poppins(
                                                      color: Colors.white
                                                  ),)));
                                            },
                                            child: Icon(Icons.delete_outline)),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                            onTap : (){
                                              //firebaseService.checkTask();
                                            },
                                            child: Icon(Icons.check_circle_outline))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              /*Text(
                                DateFormat('yyyy-MM-dd – kk:mm').format(dateTime),
                              ),*/
                            ],
                          );
                        }),
                  );
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
          },
        child: Icon(Icons.add,color: Colors.white,),),
      ),
    );
  }
}
