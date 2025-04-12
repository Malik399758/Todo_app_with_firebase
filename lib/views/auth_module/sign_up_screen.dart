import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app_firebase/views/main_home_screen/home_screen1.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;



  // sign up function
  Future<void> signUpAccountInfo(String userId) async{
    try{

      FirebaseFirestore.instance.collection('todo_app_signup_info').doc(userId).set({
        'fullName' : fullNameController.text,
        'email' : emailController.text,
        'password' : passwordController.text,
      });

    }catch(e){
      print('error ------->$e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 280,
          height: 280,
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
                  controller: fullNameController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                  ),
                ),
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
                SizedBox(height: 20,),
                // Custom button Sign up account from here

                GestureDetector(
                  onTap: ()async{
                    setState(() {
                      isLoading = true;
                    });
                    try{
                      UserCredential userId = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                          content: Text('Account created successfully!!',style: GoogleFonts.poppins(color: Colors.white),)));
                      signUpAccountInfo(userId.user!.uid);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen1()));
                      print('User id -------->${userId.toString()}');
                      setState(() {
                        isLoading = false;
                      });
                    }catch(e){
                      print('Error ---------->$e');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Something went wrong try again!!',style: GoogleFonts.poppins(color: Colors.white),)));
                      setState(() {
                        isLoading = false;
                      });
                    }finally{
                      setState(() {
                        isLoading = false;
                      });

                    }
                  },
                  child: Container(
                    width: 100,
                    height: 35,
                    color: Colors.blue,
                    child: isLoading? Center(child: SpinKitRotatingCircle(color: Colors.white,size: 10,))
                        : Center(child: Text('Signup',style: GoogleFonts.poppins(color: Colors.white,),)),
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

