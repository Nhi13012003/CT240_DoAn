import 'package:ct240_doan/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ct240_doan/screens/home_screen.dart';
import 'package:ct240_doan/auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
   createState() => _VerifyEmailPageStage();
}

class _VerifyEmailPageStage extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {

    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    }
    catch (e) {
      print("Đã có lỗi xảy ra: $e");
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ?HomeScreen():Scaffold(
    appBar: AppBar(
      title: Text('Xác minh'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Một Email xác minh đã được gửi cho bạn.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.blue,
            ),
            icon: Icon(Icons.email, size: 32, color: Colors.white,),
            label: Text(
              'Gửi lại Email',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
              ),
            ),
            onPressed: sendVerificationEmail,
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.blue,
            ),
            icon: Icon(Icons.arrow_back, size: 32, color: Colors.white,),
            label: Text(
              'Trở lại',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
          )
        ],
      ),
    ),
  );
}