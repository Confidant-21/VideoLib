import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'OTPPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.white70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/recording.png'),
                  // image: NetworkImage(
                  //     'https://imgs.search.brave.com/R32b0YYFu5NFWlw7AVpmdE8twUFEY_HlXjGMKYCsI94/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9j/b21wdXRlci1zZWN1/cml0eS13aXRoLWxv/Z2luLXBhc3N3b3Jk/LXBhZGxvY2tfMTA3/NzkxLTE2MTkxLmpw/Zw'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  //  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      hintText: 'Enter your number with country code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                        });

                    FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException ex) {},
                        codeSent: (String verificationid, int? resendtoken) {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPPage(
                                        verificationID: verificationid,
                                      )));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                        phoneNumber: _phoneController.text.toString());
                  },
                  icon: Icon(Icons.login_rounded),
                  label: Text('Proceed'))
            ],
          )),
    );
  }
}
