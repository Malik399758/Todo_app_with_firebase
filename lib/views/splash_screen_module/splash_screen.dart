import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_firebase/views/auth_module/signup_signin_screen.dart';
import 'package:todo_app_firebase/views/main_home_screen/home_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final currentUser = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),checkUser);
  }

  void checkUser(){
    if(currentUser != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen1()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupSigninScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/Animation - 1744522227518.json',height: 130),
            Text('Todo App',style: GoogleFonts.poppins(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
            SpinKitRotatingCircle(color: Colors.white,size: 15,)
          ],
        ),
      )
    );
  }
}
