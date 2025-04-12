import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/views/auth_module/home_screen.dart';
import 'package:todo_app_firebase/views/auth_module/sign_in_screen.dart';
import 'package:todo_app_firebase/views/auth_module/sign_up_screen.dart';

class SignupSigninScreen extends StatefulWidget {
  const SignupSigninScreen({super.key});

  @override
  State<SignupSigninScreen> createState() => _SignupSigninScreenState();
}

class _SignupSigninScreenState extends State<SignupSigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Todo App',style: GoogleFonts.poppins(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.topRight,
                child: Image.asset('assets/images/main_profile.png',height: 220,)),
            SizedBox(height: 30,),
            Text("Let's\nget started",style: GoogleFonts.poppins(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('Everything starts from here',style: GoogleFonts.poppins(fontSize: 15,color: Colors.white),),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade300
                ),
                child: Center(child: Text('Login',style: GoogleFonts.poppins(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),)),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                child: Center(child: Text('Sign up',style: GoogleFonts.poppins(fontSize: 18,color: Colors.blue.shade400,fontWeight: FontWeight.w600),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
