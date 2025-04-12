import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/views/auth_module/sign_in_screen.dart';
import 'package:todo_app_firebase/views/auth_module/sign_up_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
              tabs: [
                Text('Login',style: GoogleFonts.poppins(),),
                Text('Signup',style: GoogleFonts.poppins(),)
          ]),
          title: Text('Login & Signup',style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        body: TabBarView(
            children: [
              SignInScreen(),
              //Center(child: Text('Login')),
              SignUpScreen(),
              //Center(child: Text('Signup'))
        ]),
      ),
    );
  }
}
