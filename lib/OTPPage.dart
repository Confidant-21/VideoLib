import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class OTPPage extends StatefulWidget {
  String verificationID;

  OTPPage({super.key, required this.verificationID});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController _OTPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _OTPController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verificationID,
                          smsCode: _OTPController.text.toString());
                  FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  }  );
                } catch (ex) {
                  log(ex.toString() as num);
                }
              },
              icon: Icon(Icons.verified_user_outlined),
              label: Text('Verify'))
        ],
      ),
    );
  }
}
