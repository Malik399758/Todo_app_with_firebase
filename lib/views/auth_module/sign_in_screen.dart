import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/views/main_home_screen/home_screen1.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 280,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 30,),
                // sign in here

                GestureDetector(
                  onTap: ()async{
                    setState(() {
                      isActive = true;
                    });
                    try{
                     UserCredential userId =  await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                     if (userId.user?.uid.isNotEmpty ?? false) {
                       // If userId.user is not null and uid is not empty
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           backgroundColor: Colors.green,
                           content: Text('Login Successfully!!'),
                         ),
                       );
                       Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(builder: (context) => HomeScreen1()),
                       );
                     } else {
                       // If userId.user is null or uid is empty
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           backgroundColor: Colors.red,
                           content: Text('User does not exist!!'),
                         ),
                       );
                     }

                     setState(() {
                        isActive = false;
                      });
                    }catch(e){
                      print('Error ------->$e');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: SnackBar(content: Text('Login error try again!!'))));
                      setState(() {
                        isActive = false;
                      });
                    }finally{
                      setState(() {
                        isActive = false;
                      });
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 35,
                    color: Colors.blue,
                    child: isActive ? Center(child: SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 10,
                    )) : Center(child: Text('Login',style: GoogleFonts.poppins(color: Colors.white,),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

