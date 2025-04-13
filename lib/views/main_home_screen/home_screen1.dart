/*
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
*/
/*Text(
                                DateFormat('yyyy-MM-dd – kk:mm').format(dateTime),
                              ),*//*


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

*/

//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/views/main_home_screen/add_task_screen.dart';

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  String filter = 'All';

  // Add Task Controller
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Function to mark task as completed
  Future<void> markTaskAsCompleted(String docId, bool isCompleted) async {
    await FirebaseFirestore.instance
        .collection('todo_app_details')
        .doc(docId)
        .update({
      'isCompleted': !isCompleted, // Toggle the completion status
    });
  }

  // Function to delete a task
  Future<void> deleteTask(String docId) async {
    await FirebaseFirestore.instance
        .collection('todo_app_details')
        .doc(docId)
        .delete();
  }

  // Function to edit a task
  Future<void> editTask(String docId) async {
    // Show the dialog with pre-filled data for editing
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Update the task
              FirebaseFirestore.instance.collection('todo_app_details').doc(docId).update({
                'title': titleController.text,
                'description': descriptionController.text,
                'timestamp': Timestamp.now(), // Optionally update timestamp
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          title: Text('Todo App',style: GoogleFonts.poppins(color: Colors.white),),
          actions: [
            DropdownButton<String>(
              value: filter,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: Colors.blue,
              underline: SizedBox(),
              onChanged: (String? newValue) {
                setState(() {
                  filter = newValue!;
                });
              },
              items: ['All', 'Completed', 'Incomplete']
                  .map((String value) => DropdownMenuItem(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.white)),
              ))
                  .toList(),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('todo_app_details')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Handle errors
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // Check if data is available
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No tasks found.'));
            }

            final docs = snapshot.data!.docs;
            final filtered = docs.where((doc) {
              final data = doc.data() as Map<String, dynamic>;

              // Check if 'isCompleted' field exists before accessing it
              final isCompleted = data.containsKey('isCompleted') ? data['isCompleted'] : false;

              if (filter == 'Completed') return isCompleted == true;
              if (filter == 'Incomplete') return isCompleted == false;
              return true;
            }).toList();

            return ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final doc = filtered[index];
                final data = doc.data() as Map<String, dynamic>;
                final title = data['title'] ?? 'Untitled';
                final desc = data['description'] ?? 'No description';
                final isCompleted = data['isCompleted'] ?? false;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: isCompleted ? Colors.green[100] : Colors.white,
                  child: ListTile(
                    title: Text(
                      title,
                      style: TextStyle(
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      desc,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Edit Task
                            editTask(doc.id);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Delete Task
                            deleteTask(doc.id);
                          },
                        ),
                        Icon(
                          isCompleted ? Icons.check_circle : Icons.circle_outlined,
                          color: isCompleted ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                    onTap: () {
                      // Toggle completion status when tapping the task
                      FirebaseFirestore.instance
                          .collection('todo_app_details')
                          .doc(doc.id)
                          .update({'isCompleted': !isCompleted});
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
          },
        ),
      ),
    );
  }
}

